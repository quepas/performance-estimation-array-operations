source("SNRMSE.R")
source("loadMeasurement.R")

# vrand, vsum
estimateMCPI <- function(performanceAspect, resultsDir = "../results/Octave4/", env = "") {
  MCPI <- loadMeasurement("MCPI", performanceAspect, resultsDir);
  vrand <- loadMeasurement("vrand", performanceAspect, resultsDir)
  vsum <- loadMeasurement("vsum", performanceAspect, resultsDir)
  vsquare <- loadMeasurement("vsquare", performanceAspect, resultsDir)
  vsquaresquare <- loadMeasurement("vsquaresquare", performanceAspect, resultsDir)
  vadd2 <- loadMeasurement("vadd2", performanceAspect, resultsDir)
  vadd3 <- loadMeasurement("vadd3", performanceAspect, resultsDir)
  vless2 <- loadMeasurement("vless2", performanceAspect, resultsDir)
  vless3 <- loadMeasurement("vless3", performanceAspect, resultsDir)
  
  x <- vrand$elements
  naive_method <- 2 * vrand$avg +
    vsum$avg + 
    vadd2$avg +
    2 * vsquare$avg +
    vless2$avg
  
  one_sided_method <- 2 * vrand$avg +
    vsum$avg + 
    vadd3$avg - vadd2$avg + 
    2 * (vsquaresquare$avg - vsquare$avg) +
    vless3$avg - vless2$avg
  
  naive_err <- SNRMSE(MCPI$avg, naive_method)
  one_sided_err <- SNRMSE(MCPI$avg, one_sided_method)
  
  plot(x, MCPI$avg, type="l", main = sprintf("MCPI : %s (naive: %.2f%%; one-sided: %.2f%%) @ %s", performanceAspect, naive_err, one_sided_err, env))
  lines(x, naive_method, lty=2, col="gray") 
  lines(x, one_sided_method, lty=2, col="red")
  data.frame("MCPI.naive_err"=naive_err, "MCPI.one_sided_err"=one_sided_err)
}
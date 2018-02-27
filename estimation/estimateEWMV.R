source("SNRMSE.R")
source("loadMeasurement.R")

# Estimate Element-Wise Matrix-Vector multiplication (EWMV)
estimateEWMV <- function(performanceAspect, resultsDir = "../results/Octave4/", env = "") {
  EWMV <- loadMeasurement("EWMV", performanceAspect, resultsDir)
  vrepmat <- loadMeasurement("vrepmat", performanceAspect, resultsDir)
  vrepmatneg <- loadMeasurement("vrepmatneg", performanceAspect, resultsDir)
  vneg <- loadMeasurement("vneg", performanceAspect, resultsDir)
  vmul2 <- loadMeasurement("vmul2", performanceAspect, resultsDir)
  
  naive_method <- vrepmat$avg + vmul2$avg
  one_sided_method <- (vrepmatneg$avg - vneg$avg) + vmul2$avg

  naive_err <- SNRMSE(EWMV$avg, naive_method)
  one_sided_err <- SNRMSE(EWMV$avg, one_sided_method)
  
  x <- EWMV$elements
  plot(x, EWMV$avg, type="l", main = sprintf("EWMV : %s (naive: %.2f%%; one-sided: %.2f%%) @ %s", performanceAspect, naive_err, one_sided_err, env))
  lines(x, naive_method, lty=2, col="gray") 
  lines(x, one_sided_method, lty=2, col="red")
  data.frame("EWMV.naive_err"=naive_err, "EWMV.one_sided_err"=one_sided_err)
}

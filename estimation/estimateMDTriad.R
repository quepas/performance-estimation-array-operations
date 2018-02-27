source("SNRMSE.R")
source("loadMeasurement.R")

# Estimate Multi-dimensional Triad (MD-Triad0)
estimateMDTriad <- function(performanceAspect, resultsDir = "../results/Octave4/", env = "") {
  MDTriad <- loadMeasurement("MD_triad", performanceAspect, resultsDir)
  vadd2 <- loadMeasurement("vadd2", performanceAspect, resultsDir)
  vmul2 <- loadMeasurement("vmul2", performanceAspect, resultsDir)
  vmul3 <- loadMeasurement("vmul3", performanceAspect, resultsDir)
  
  naive_method <- vadd2$avg + vmul2$avg
  one_sided_method <- vadd2$avg + (vmul3$avg - vmul2$avg)
  
  naive_err <- SNRMSE(MDTriad$avg, naive_method)
  one_sided_err <- SNRMSE(MDTriad$avg, one_sided_method)
  
  x <- MDTriad$elements
  plot(x, MDTriad$avg, type="l", main = sprintf("MDTriad : %s (naive: %.2f%%; one-sided: %.2f%%) @ %s", performanceAspect, naive_err, one_sided_err, env))
  lines(x, naive_method, lty=2, col="gray") 
  lines(x, one_sided_method, lty=2, col="red")
  data.frame("MDTriad.naive_err"=naive_err, "MDTriad.one_sided_err"=one_sided_err)
}

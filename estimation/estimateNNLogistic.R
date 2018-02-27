source("SNRMSE.R")
source("loadMeasurement.R")

estimateNNLogistic <- function(performanceAspect, resultsDir = "../results/Octave4/", env = "") {
  NNLogistic <- loadMeasurement("FNN_logistic", performanceAspect, resultsDir)
  vneg <- loadMeasurement("vneg", performanceAspect, resultsDir)
  vnegneg <- loadMeasurement("vnegneg", performanceAspect, resultsDir)
  vexp <- loadMeasurement("vexp", performanceAspect, resultsDir)
  vadd2 <- loadMeasurement("vadd2", performanceAspect, resultsDir)
  vadd3 <- loadMeasurement("vadd3", performanceAspect, resultsDir)
  vdiv2 <- loadMeasurement("vdiv2", performanceAspect, resultsDir)
  vdiv3 <- loadMeasurement("vdiv3", performanceAspect, resultsDir)
  
  naive_method <- vneg$avg + vexp$avg + vadd2$avg + vdiv2$avg
   
  one_sided_method <- (vnegneg$avg - vneg$avg) + (vadd3$avg - vadd2$avg) + (vdiv3$avg - vdiv2$avg) + vexp$avg 
  
  naive_err <- SNRMSE(NNLogistic$avg, naive_method)
  one_sided_err <- SNRMSE(NNLogistic$avg, one_sided_method)
  
  x <- NNLogistic$elements
  plot(x, NNLogistic$avg, type="l", main = sprintf("NN-Logistic : %s (naive: %.2f%%; one-sided: %.2f%%) @ %s", performanceAspect, naive_err, one_sided_err, env))
  lines(x, naive_method, lty=2, col="gray") 
  lines(x, one_sided_method, lty=2, col="red")
  data.frame("NNLogistic.naive_err"=naive_err, "NNLogistic.one_sided_err"=one_sided_err)
}
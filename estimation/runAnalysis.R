source("estimateEWMV.R")
source("estimateMCPI.R")
source("estimateMDTriad.R")
source("estimateNNLogistic.R")

### CHANGE THIS !!! ###
# >> Where your measurements are?
measurementsDir <- "../backup/RUN5_23_02_32MB_Py2Py3/"
# >> What performance aspects you are analyzing? (TIME + PAPI events)
aspects <- c("TIME", "PAPI_L1_DCM", "PAPI_TOT_INS") #PAPI_BR_INS", "PAPI_LST_INS", "PAPI_TOT_INS")
# >> For what languages/environments you did run your analysis? (names of directories inside measurementsDir)
languages <- c("Python2", "Python3")#R14b_ST", "R14b_MT", "R16b_ST", "R16b_MT", "Octave", "Scilab")
#######################

result <- list()
# For each performance aspect
for (aspect in aspects) {
  cat(sprintf("%s\n", aspect))
  
  aspectResults <- data.frame(nums = 1:8) # 8 == num. of estimators * 2 (two methods: naive and one-sided)
  # For each language
  for (lang in languages) {
    dir <- paste(measurementsDir, lang, sep="/")
    langResults <- data.frame()
    langResults <- rbind(langResults, t(estimateMCPI(aspect, dir, lang)))
    langResults <- rbind(langResults, t(estimateEWMV(aspect, dir, lang)))
    langResults <- rbind(langResults, t(estimateNNLogistic(aspect, dir, lang)))
    langResults <- rbind(langResults, t(estimateMDTriad(aspect, dir, lang)))
    colnames(langResults) <- lang
    aspectResults <- cbind(aspectResults, langResults)
  }
  result[[aspect]] <- aspectResults[, -1] # remove dummy nums columns
}

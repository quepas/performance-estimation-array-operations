loadMeasurement <- function(arrayOp, aspect, dir = "../results/") {
  data <- read.csv(paste(dir, "/", arrayOp, "_", aspect, ".csv", sep=""), header = FALSE)
  colnames(data) <- c("elements", "min", "avg", "max", "std")
  data
}
### Mean Signed Deviation (MSD)
#     Source: https://www.wikiwand.com/en/Mean_signed_deviation
#     Used for finding underestimation (minus errors)
###
MSD <- function(observation, estimate) {
  n <- length(estimate)
  sum((estimate - observation)/n)
}
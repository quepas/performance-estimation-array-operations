library(hydroGOF)
source("MSD.R")

### Signed Normalized Root-Mean-Square Error (SNRMSE)
#     Source: https://www.wikiwand.com/en/Root-mean-square_deviation#/Normalized_root-mean-square_deviation
#     Used for measuring accuracy of our estimates (the closer to zero the better!)
#     Notice: We are using MSD error for calculating underestimation !
###
SNRMSE <- function(observation, estimate) {
  sign(MSD(observation, estimate)) * nrmse(observation, estimate)
}
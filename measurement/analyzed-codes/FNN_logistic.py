import numpy as np


# FNN-logistic > Logistic function used
#              > as an activation function in neural networks
# Array operations
#  * vneg (x1)
#  * vexp (x1)
#  * vadd2 (x1)
#  * vdiv2 (x1)
####
def FNN_logistic(A):
    R = np.divide(1, np.add(1, np.exp(np.negative(A))))

import numpy as np


# EWMV > Element - wise matrix - vector multiplication
# Array operations:
# * vrepmat(x1)
# * vmul2(x1)
# # ##
def EWMV(M, V):
    N = M.shape[0]
    # (!) simple lookup function discarded
    R = np.multiply(M, np.tile(V, (N, 1)))  # vrepmat, vmul2

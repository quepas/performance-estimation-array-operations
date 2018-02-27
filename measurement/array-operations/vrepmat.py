import numpy as np


# Replicate row-vector two form a square matrix
def vrepmat(V):
    N = np.size(V)  # % (!) lookup function discarded
    R = np.tile(V, (N, 1))

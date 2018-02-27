import numpy as np


# Replicate row-vector two form a square matrix
def vrepmatneg(V):
    N = np.size(V)  # % (!) lookup function discarded
    R = np.negative(np.tile(V, (N, 1)))

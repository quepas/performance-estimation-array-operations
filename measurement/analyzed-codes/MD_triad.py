import numpy as np


# Triad over multi-dimensional arrays (N x 2 x 4 x 8)
# Array opeations (all in multi-dimensional context):
#  * vadd2 (x1)
#  * vmul2 (x1)
####
def MD_triad(MD1, MD2, MD3):
    R = np.add(MD1, np.multiply(MD2, MD3))

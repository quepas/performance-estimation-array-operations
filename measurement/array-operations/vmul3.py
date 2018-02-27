import numpy as np


# Element-wise multiplication of three vectors
def vmul3(V1, V2, V3):
    R = np.multiply(V1, np.multiply(V2, V3))

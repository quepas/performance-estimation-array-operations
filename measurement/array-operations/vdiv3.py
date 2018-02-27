import numpy as np


# Element-wise division of threea vectors
def vdiv3(V1, V2, V3):
    R = np.divide(V1, np.divide(V2, V3))

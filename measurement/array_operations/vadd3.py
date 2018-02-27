import numpy as np


# Element-wise addition of three vectors
def vadd3(V1, V2, V3):
    R = np.add(V1, np.add(V2, V3))

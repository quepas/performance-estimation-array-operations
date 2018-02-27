import numpy as np


# Element-wise comparision of three vectors (less then)
def vless3(V1, V2, V3):
    R = np.less(np.less(V1, V2), V3)

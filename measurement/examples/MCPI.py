import numpy as np


# MCPI > Monte-Carlo PI estimation
# Array opeations:
#  * vrand (x2)
#  * vsum (x1)
#  * vsquare (x2)
#  * vadd2 (x1)
#  * vless2 (x1)
####
def MCPI(N):
    # Generate N points (x, y) with x,y in [0, 1]
    x = np.random.rand(1, N)  # vrand
    y = np.random.rand(1, N)  # vrand
    # Count points in circle
    # vsum, vsquare, vadd2, vless2
    pointsInCircle = np.sum(
        np.less((np.add(np.power(x, 2), np.power(y, 2))), 1))
    # Compute ratio of points in circle and all points
    piValue = 4 * pointsInCircle / N  # (!) scalars discarded

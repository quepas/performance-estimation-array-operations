from array_operations import *
from examples import *

import numpy as np
import time
from pypapi import papi_high
from pypapi import events as papi_events

##### Config #####
L1 = 32  # L1 cache size in kB
L2 = 256  # L2 cache size in kB
L3 = 4096  # L3 cache size in kB
MAX = 32 * 1024  # Maximum data size estimated in kB
NUM_ELEM = np.concatenate(
    (np.arange((L1 / 4), (2 * L1) + 1, (L1 / 4)), np.arange((L2 / 4), (2 * L2) + 1, (L2 / 4))))
NUM_ELEM = np.concatenate(
    (NUM_ELEM, np.arange((L3 / 4), (2 * L3) + 1, (L3 / 4))))
NUM_ELEM = np.concatenate((NUM_ELEM, np.arange(L3, MAX + 1, L3)))
NUM_ELEM = np.unique(NUM_ELEM) * 128
NUM_ELEM = np.array([256, 512])
MEASURE_REPEATS = 35  # Total number of measurements (including cutoff)
CUTOFF = 5  # Number of discarded first measurements
ASPECTS = ['TIME', 'PAPI_L1_DCM', 'PAPI_TOT_INS']
VERBOSE = False  # Be verbose about measurements (min, mean, max, std)
#RESULTS_DIR = './results/Python3'
##### Config #####


def restartPAPI(aspect):
    try:
        papi_high.stop_counters()
    except:
        pass
    if aspect == 'PAPI_L1_DCM':
        papi_high.start_counters([papi_events.PAPI_L1_DCM])
    elif aspect == 'PAPI_TOT_INS':
        papi_high.start_counters([papi_events.PAPI_TOT_INS])


def ruthonTest(arrayOp, input, aspect):
    result = np.ones((np.size(NUM_ELEM), 5))
    for dataId in range(0, np.size(NUM_ELEM)):
        N = int(NUM_ELEM[dataId])
        measurements = np.zeros((1, MEASURE_REPEATS))
        for measureRun in range(0, MEASURE_REPEATS):
            # Create data and run !
            if input == 'V1':
                V1 = np.random.rand(1, N)
                if aspect == 'TIME':
                    t = time.time()
                    arrayOp(V1)
                    measurements[0, measureRun] = time.time() - t
                else:
                    papi_high.read_counters()
                    arrayOp(V1)
                    measurements[0, measureRun] = papi_high.read_counters()[0]
            elif input == 'V2':
                V1 = np.random.rand(1, N)
                V2 = np.random.rand(1, N)
                if aspect == 'TIME':
                    t = time.time()
                    arrayOp(V1, V2)
                    measurements[0, measureRun] = time.time() - t
                else:
                    papi_high.read_counters()
                    arrayOp(V1, V2)
                    measurements[0, measureRun] = papi_high.read_counters()[0]
            elif input == 'V3':
                V1 = np.random.rand(1, N)
                V2 = np.random.rand(1, N)
                V3 = np.random.rand(1, N)
                if aspect == 'TIME':
                    t = time.time()
                    arrayOp(V1, V2, V3)
                    measurements[0, measureRun] = time.time() - t
                else:
                    papi_high.read_counters()
                    arrayOp(V1, V2, V3)
                    measurements[0, measureRun] = papi_high.read_counters()[0]
            elif input == 'VSR':
                VSR = np.random.rand(1, int(np.sqrt(N)))
                if aspect == 'TIME':
                    t = time.time()
                    arrayOp(VSR)
                    measurements[0, measureRun] = time.time() - t
                else:
                    papi_high.read_counters()
                    arrayOp(VSR)
                    measurements[0, measureRun] = papi_high.read_counters()[0]
            elif input == 'MD3':
                MD1 = np.random.rand(int(N / 64), 2, 4, 8)
                MD2 = np.random.rand(int(N / 64), 2, 4, 8)
                MD3 = np.random.rand(int(N / 64), 2, 4, 8)
                if aspect == 'TIME':
                    t = time.time()
                    arrayOp(MD1, MD2, MD3)
                    measurements[0, measureRun] = time.time() - t
                else:
                    papi_high.read_counters()
                    arrayOp(MD1, MD2, MD3)
                    measurements[0, measureRun] = papi_high.read_counters()[0]
            elif input == 'MVSR':
                M = np.random.rand(int(np.sqrt(N)), int(np.sqrt(N)))
                VSR = np.random.rand(1, int(np.sqrt(N)))
                if aspect == 'TIME':
                    t = time.time()
                    arrayOp(M, VSR)
                    measurements[0, measureRun] = time.time() - t
                else:
                    papi_high.read_counters()
                    arrayOp(M, VSR)
                    measurements[0, measureRun] = papi_high.read_counters()[0]
            elif input == 'N':
                if aspect == 'TIME':
                    t = time.time()
                    arrayOp(N)
                    measurements[0, measureRun] = time.time() - t
                else:
                    papi_high.read_counters()
                    arrayOp(N)
                    measurements[0, measureRun] = papi_high.read_counters()[0]

        measurements = measurements[0, CUTOFF:MEASURE_REPEATS];
        # Prepare final results
        result[dataId, :] = np.array([N, np.min(measurements), np.mean(
            measurements), np.max(measurements), np.std(measurements)]);
        # Log intermadiate results
        if VERBOSE:
            print('Num. of elements %d (min: %f, avg: %f, max: %f, std: %f)\n' % (N,
                                                                                  result[dataId, 1], result[dataId, 2], result[dataId, 3], result[dataId, 4]));
    # print result.shape[0]
    resultfilename = RESULTS_DIR + "/" + \
        str(arrayOp.__name__) + "_" + str(aspect) + '.csv'
    # csv.writer(open(resultfilename, 'w'), result)
    np.savetxt(resultfilename, result, delimiter=',')



###### Main script ######
print("Measuring Array Operations...\n")
print('\tNum. of measurement repetitions = %d (cutoff first: %d)' %
      (MEASURE_REPEATS, CUTOFF));
print('\tMin. and max. num. of elements = (%d, %d)' %
      (NUM_ELEM[1], NUM_ELEM[NUM_ELEM.size - 1]))

# Measured array operators
arrayOps = {
    vadd2.vadd2: 'V2',
    vadd3.vadd3: 'V3',
    vdiv2.vdiv2: 'V2',
    vdiv3.vdiv3: 'V3',
    vexp.vexp: 'V1',
    vless2.vless2: 'V2',
    vless3.vless3: 'V3',
    vmul2.vmul2: 'V2',
    vmul3.vmul3: 'V3',
    vneg.vneg: 'V1',
    vnegneg.vnegneg: 'V1',
    vrand.vrand: 'N',
    vrepmat.vrepmat: 'VSR',
    vrepmatneg.vrepmatneg: 'VSR',
    vsquare.vsquare: 'V1',
    vsquaresquare.vsquaresquare: 'V1',
    vsum.vsum: 'V1'
}

# Take measurements
for k, v in arrayOps.items():
    # Test performance aspects(e.g.time, L1 cache misses)
    for aspect in ASPECTS:
        restartPAPI(aspect)
        print("--> Measuring %s (aspect %s)" % (k.__name__, aspect))
        ruthonTest(k, v, aspect)

# Measure code examples
print("@2@ Measuring Code Examples...\n")
# Measured array operators
examples = {EWMV.EWMV: 'MVSR',
            FNN_logistic.FNN_logistic: 'V1',
            MCPI.MCPI: 'N',
            MD_triad.MD_triad: 'MD3'
            }

# Take measurements
for k, v in examples.items():
    # Test performance aspects(e.g.time, L1 cache misses)
    for aspect in ASPECTS:
        restartPAPI(aspect)
        print("--> Measuring %s (aspect %s)" % (k.__name__, aspect))
        ruthonTest(k, v, aspect)

print("All done!\n")

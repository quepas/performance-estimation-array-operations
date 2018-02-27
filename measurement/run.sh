#!/bin/sh

### CHANGE THIS !!! ###
## Paths to language interpreters
scilab="/home/quepas/Programs/scilab-6.0.1/bin/scilab"
octave="/usr/bin/octave"
matlabR14b="/usr/local/MATLAB/R2014b/bin/matlab"
matlabR16b="/usr/local/MATLAB/R2016b/bin/matlab"
python2="/usr/bin/python2.7"
python3="/usr/bin/python3.5"
## Experiment setup
# This string is an embedded MATLAB / Octave / Scilab code
# WARNING: Python configuration is in runPython.py script.
L1="config.L1 = 32;" # L1 cache size in kB
L2="config.L2 = 256;" # L2 cache size in kB
L3="config.L3 = 4096;" # L3 cache size in kB
MAX="config.MAX = 32*1024;" # Maximum data size estimated in kB
NUM_ELEM="config.NUM_ELEM = unique([(config.L1/4):(config.L1/4):(2*config.L1) (config.L2/4):(config.L2/4):(2*config.L2) (config.L3/4):(config.L3/4):(2*config.L3) config.L3:config.L3:config.MAX])*128;"
MEASURE_REPEATS="config.MEASURE_REPEATS = 35;" # Total number of measurements (including cutoff)
CUTOFF="config.CUTOFF = 5;" # Number of discarded first measurements
ASPECTS="config.ASPECTS = {'TIME', 'PAPI_L1_DCM', 'PAPI_BR_INS', 'PAPI_LST_INS', 'PAPI_TOT_INS'};"
VERBOSE="config.VERBOSE = 0;" # Be verbose about measurements (min, mean, max, std)
###

tic() {
   echo "@time Strating "$1": `date "+%Y-%m-%d %H:%M:%S"`"
}

toc() {
   echo "@time Finishing "$1": `date "+%Y-%m-%d %H:%M:%S"`"
}

# Combine all settings into one
settings="${L1}${L2}${L3}${MAX}${NUM_ELEM}${MEASURE_REPEATS}${CUTOFF}${ASPECTS}${VERBOSE}"

# Run Scilab
tic Scilab
newSettings="${settings} config.RESULTS_DIR = './results/Scilab';"
$scilab -nwni -e "${newSettings} exec runScilab.sce;quit"
toc Scilab

# Run Octave
tic Scilab
newSettings="${settings} config.RESULTS_DIR = './results/Octave';"
$octave --no-gui --no-window-system --eval "${newSettings} run runOctave.m;quit"
toc Scilab

# Run MATLAB
## Run first MATLAB
### Single-thread
tic R14b_ST
newSettings="${settings} config.RESULTS_DIR = './results/R14b_ST';"
$matlabR14b -nodesktop -nosplash -noFigureWindows -nojvm -nosoftwareopengl -singleCompThread -r "${newSettings} run runMATLAB.m;quit"
toc R14b_ST

### Multi-threads
tic R14b_MT
newSettings="${settings} config.RESULTS_DIR = './results/R14b_MT';"
$matlabR14b -nodesktop -nosplash -noFigureWindows -nojvm -nosoftwareopengl -r "${newSettings} run runMATLAB.m;quit"
toc R14b_MT

## Run second MATLAB
### Single-thread
tic R16b_ST
newSettings="${settings} config.RESULTS_DIR = './results/R16b_ST';"
$matlabR16b -nodesktop -nosplash -noFigureWindows -nojvm -nosoftwareopengl -singleCompThread -r "${newSettings} run runMATLAB.m;quit"
toc R16b_ST
### Multi-threads
tic R16b_MT
newSettings="${settings} config.RESULTS_DIR = './results/R16b_MT';"
$matlabR16b -nodesktop -nosplash -noFigureWindows -nojvm -nosoftwareopengl -r "${newSettings} run runMATLAB.m;quit"
toc R16b_MT

# Run Python
## Py2
tic Python2
$python2 -c "RESULTS_DIR='./results/Python2';execfile('runPython.py')"
toc Python2

## Py3
tic Python3
$python3 -c "RESULTS_DIR='./results/Python3';exec(open('runPython.py').read())"
toc Python3

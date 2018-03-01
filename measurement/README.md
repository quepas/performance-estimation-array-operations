# Measurement

This directory contains scripts for performing measurements on four interpreters (i.e. MATLAB, Octave, Scilab, Python).
For the measurements a set of [17 array operations](array-operations/README.md) and [4 code examples](analyzed-codes/README.md) is used.
The main script `run.sh` is responsible for running all four interpreters and performing tests.

## Performing measurements

1. Configure script `run.sh`
   * Set paths to interpreters (variables: `octave`, `scilab` etc.)
   * Set CPU related information (e.g. cache size `L1`, `L2`, `L3`)
   * Define maximum size of tested data `MAX` (the exact sampled data sizes are defined in `NUM_ELEM` entity)
   * Set performance aspects (`ASPECTS`), num. of measurement repeats (`MEASURE_REPEATS`), and cutoff value `CUTOFF` (for discarding warm-up stage measurements)
   * Set paths for results for each interpreter run (variable `RESULTS_DIR`)
2. Prepare your machine
   * Restart computer
   * Turn-off unecessary processes
   * Turn-off _Intel Turbo Boost_ (BIOS level)
3. Run configured script `run.sh`

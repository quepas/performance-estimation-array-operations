# Paper experiments

## Setup

Results in the directory `backup/` were obtained on this setup:

### Hardware

* _Intel® Core™ i7-6600U CPU @ 2.60GHz × 4_ (2 cores, cache L1 32kB for data and 32kB for instructions (x2), cache L2 256kB, cache L3 4MB shared)
* 16 GB RAM DD3 2700MHz

### Software

For tips on software installation go [here](../doc/INSTALLATION.md).

* Ubuntu 16.04.3 LTS (kernel Linux 4.4.0-112-generic x86_64)
* [PAPI 5.5.1](http://icl.cs.utk.edu/papi/)
* PAPI wrappers:
  * mPAPI for MATLAB
  * oPAPI for Octave
  * sPAPI for Scilab
  * PyPAPI for Python
* [MATLAB _R14b_, _R16b_](https://uk.mathworks.com/products/matlab.html)
* [Octave _4.2.1_](https://www.gnu.org/software/octave/)
* Scilab _6.0.1_
* Python _2.7_ + Numpy
* Python _3.5_ + Numpy
* R (prefered: __)

## Results

Results cosists of measurements of three performance aspects: time, L1 cache misses, total instructions count.
Each result file contains file columns:

* Size of data (num. of elements)
* Measurement statistics:
  * minimum value
  * average (mean value)
  * maximum value
  * standard deviation


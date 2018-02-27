# Installation

### PAPI

PAPI on Ubuntu is installed from package manager:

```bash
sudo apt-get update
sudo apt-get install papi-tools
```

Wrappers for PAPI for MATLAB, Octave, and Scilab is available in directory `tools/`

### MATLAB

[MATLAB](https://www.mathworks.com/products/matlab.html) is a propertiary software.
In case of absence of MATLAB license, skip this section and install free alternatives: Octave or Scilab.
Otherwise, go to the [Download Page](https://mathworks.com/downloads/) and follow installation instructions.
The experiment were run on MATLAB R14b and R16b.
However, any MATLAB version can be used in the experiment.

### Octave

[GNU Octave](https://www.gnu.org/software/octave/) is provided by [Linux distributions](https://wiki.octave.org/Octave_for_GNU/Linux).
On Ubuntu install Octave with these commands:

```bash
sudo apt-add-repository ppa:octave/stable
sudo apt-get update
sudo apt-get install octave
```

In case of any questions go to [Octave FAQ](https://wiki.octave.org/FAQ).

### Scilab

[Scilab](http://www.scilab.org/) requires manual installation.
Download and extract [Scilab 6.0.1](http://www.scilab.org/download/6.0.1/scilab-6.0.1.bin.linux-x86_64.tar.gz).
You can create a symbolic link to `scilab` binary, although it is not required.

### Python

* [How to install PIP with Python3](https://stackoverflow.com/questions/6587507/how-to-install-pip-with-python-3)
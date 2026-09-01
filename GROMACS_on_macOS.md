# GROMACS installation on macOS

Compiling and installing GROMACS on macOS requires several dependencies, which are easily installed with the [Homebrew package manager](https://brew.sh/).
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install `cmake` (cross-platform build system) and `gcc` (GNU Compiler Collection).
```bash
brew install cmake gcc@16
```

Download and extract the GROMACS 2026.3 source code.
```bash
wget https://ftp.gromacs.org/gromacs/gromacs-2026.3.tar.gz
tar -xvzf gromacs-2026.3.tar.gz
```

Enter the extracted GROMACS source directory and create a separate build directory.
```bash
cd gromacs-2026.3
mkdir build
cd build
```

Configure GROMACS to use GCC, build its own FFTW library, download regression tests, disable HDF5, and install into the user's home directory.
```bash
cmake .. \
    -DCMAKE_C_COMPILER=/opt/homebrew/bin/gcc-16 \
    -DCMAKE_CXX_COMPILER=/opt/homebrew/bin/g++-16 \
    -DGMX_BUILD_OWN_FFTW=ON \
    -DREGRESSIONTEST_DOWNLOAD=ON \
    -DCMAKE_INSTALL_PREFIX=/Users/$USER/gromacs-2026.3 \
    -DGMX_USE_HDF5=OFF
```

Compile GROMACS and run the test suite.
```bash
make -j8
make -j8 check
```

Install GROMACS into the user's home directory.
```bash
make install
```

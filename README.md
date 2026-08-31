# Running the cluster_mdrun Pipeline

1. Adjust the SLURM submission script `mdrun.slurm`, for example you can add your email address.
2. Place the `.tpr` run input files in the `/data` directory.
3. Submit the pipeline with:

```bash
sbatch mdrun.slurm
```


## Installing GROMACS on the UZH ScienceCluster

Start an interactive SLURM session.
```bash
srun --pty -c 8 --time=1:00:00 --mem=16G bash -l
```
Load the Miniforge module and create a Mamba environment containing CMake.
```bash
module load miniforge3
mamba env create -n cmake conda-forge::cmake
```

Initialize Mamba and activate the CMake environment.
```bash
eval "$(mamba shell hook --shell bash)"
mamba activate cmake
```

Change to the scratch directory and do.
```bash
cd scratch
```

Download and extract the GROMACS 2026.3 source code.
```bash
wget https://ftp.gromacs.org/gromacs/gromacs-2026.3.tar.gz
tar -xvzf gromacs-2026.3.tar.gz
```

Enter the extracted GROMACS source directory and create a separate directory for the build files.
```bash
cd gromacs-2026.3
mkdir build
cd build
```

Configure GROMACS to build its own FFTW library, download regression tests, disable HDF5, and install into the user's home directory.
```bash
cmake .. \
    -DGMX_BUILD_OWN_FFTW=ON \
    -DREGRESSIONTEST_DOWNLOAD=ON \
    -DCMAKE_INSTALL_PREFIX=/home/$USER/gromacs-2026.3 \
    -DGMX_USE_HDF5=OFF
```

Compile GROMACS and run the GROMACS test suite.
```bash
make -j8
make -j8 check
```

Install GROMACS into the into the user's home directory.
```bash
make install
```

## Installing NextFlow on the UZH ScienceCluster
Start an interactive SLURM session.
```bash
srun --pty -c 8 --time=1:00:00 --mem=16G bash -l
```
Load the Miniforge module and create a Mamba environment containing NextFlow.
```bash
module load miniforge3
mamba env create -n nextflow bioconda::nextflow
```

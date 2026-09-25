# Running gmx-mdrun-slurm on the UZH ScienceCluster

1. Adjust the SLURM submission script `mdrun.slurm`, for example you can add your email address.
2. Place the `.tpr` run input files in the `/data` directory.
3. Submit the pipeline with:

```bash
sbatch mdrun.slurm
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

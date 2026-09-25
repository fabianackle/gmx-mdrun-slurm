params.data   = "data/*.tpr"
params.outdir = "results"

workflow {
    log.info(
        """
        ┌───────────────────────────┐
        │ G R O M A C S   M D R U N │
        │ by Fabian Ackle           │  
        └───────────────────────────┘
        """.stripIndent()
    )

    tpr_ch = channel.fromPath(params.data, checkIfExists: true).map { file -> tuple(file.baseName, file) }

    MDRUN(tpr_ch)
}

process MDRUN {
    container "oras://ghcr.io/fabianackle/gromacs:2026.3-r1"
    tag "${sample_id}"

    publishDir params.outdir, mode: 'copy'

    input:
    tuple val(sample_id), path(tpr)

    output:
    tuple val(sample_id), path("${sample_id}.xtc"), path("${sample_id}.tpr")

    script:
    """
    gmx -version > gromacs_version.log
    gmx mdrun -v -deffnm ${sample_id} -pin on -pinstride 1
    """
}

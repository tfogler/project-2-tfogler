#!/bin/bash

# Define num jobs to be submitted
JOBS=5

# List of directories or Snakefiles
SNAKEFILES=(
    "/projectnb/bf528/students/tfogler/project-2-tfogler/week1.snake"
    "/projectnb/bf528/students/tfogler/project-2-tfogler/week2.snake"
    "/projectnb/bf528/students/tfogler/project-2-tfogler/week3.snake"
    # Add more paths to Snakefiles as needed
)
# Set the qsub command template
QSUB_CMD="qsub -P bf528 -pe omp {threads}"

# Iterate through each Snakefile and submit the Snakemake command as a qsub job
for SNAKEFILE in "${SNAKEFILES[@]}"; do
    # Define the Snakemake command with the appropriate options for each Snakefile
    SNAKEMAKE_COMMAND="snakemake -s $SNAKEFILE --sdm conda --executor cluster-generic --cluster-generic-submit-cmd \"$QSUB_CMD\" --jobs $JOBS"
    
    # Submit the Snakemake command as a qsub job
    echo "Submitting job for Snakefile: $SNAKEFILE \
    "
    eval $SNAKEMAKE_COMMAND
done

#!/bin/bash
#SBATCH --time=6:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --job-name=adventofcode15
#SBATCH --output=adventofcode15.out
#SBATCH --mem-per-cpu=1500M

module load MATLAB/2020b 
matlab -nodisplay < adventofcode15.m
#!/bin/bash
#SBATCH --job-name=pl_multi_gpu
#SBATCH --output=pl_multi_gpu_%j.out
#SBATCH --error=pl_multi_gpu_%j.err
#SBATCH --time=02:00:00
#SBATCH --gres=gpu:4
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=8
#SBATCH --partition=e8

srun singularity exec --env-file .env --nv out/pytorch_nn.sif python pl_train_script.py

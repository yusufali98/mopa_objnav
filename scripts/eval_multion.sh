#!/bin/bash
#SBATCH --job-name=objnav
#SBATCH --output=slurm_logs/objnav-%j.out
#SBATCH --error=slurm_logs/objnav-%j.err
#SBATCH -G a40:1
#SBATCH --nodes 1
#SBATCH -c 12
#SBATCH --ntasks-per-node 1
#SBATCH --qos=short
#SBATCH --partition=kira-lab
#SBATCH --signal=USR1@100
#SBATCH --requeue

export GLOG_minloglevel=2
export HABITAT_SIM_LOG=quiet
export MAGNUM_LOG=quiet

MAIN_ADDR=$(scontrol show hostnames "${SLURM_JOB_NODELIST}" | head -n 1)
export MAIN_ADDR

source /srv/kira-lab/share4/yali30/mamba/mamba_install/etc/profile.d/conda.sh
conda deactivate
conda activate mopa_mon

cd /srv/kira-lab/share4/yali30/mopa_multion/mopa

srun python -u run.py --exp-config baselines/config/pointnav/hier_w_proj_ora_sem_map_objnav.yaml --run-type eval
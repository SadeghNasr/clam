#!/bin/bash

#SBATCH --job-name=initial_experiment
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mohammadsadegh.nasr@mavs.uta.edu
#SBATCH --partition=conference
#SBATCH --account=conference
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=128gb
#SBATCH --gres=gpu:2
#SBATCH --time=120:00:00
#SBATCH --error=/home/mxn2498/projects/vae_mlp_head/general/LOGS/SLURM/initial_experiment.err
#SBATCH --output=/home/mxn2498/projects/vae_mlp_head/general/LOGS/SLURM/initial_experiment.out

function fail {
    echo "FAIL: $@" >&2
    exit 1  # signal failure
}

source /home/mxn2498/miniconda3/etc/profile.d/conda.sh || fail "conda load fail"
conda activate clam || fail "conda activate fail"

cd /home/mxn2498/projects/clam

python create_patches_fp.py --source DATA_DIRECTORY --primary_site Breast --num_slides -1 --random_seed 0 --save_dir RESULTS_DIRECTORY --patch_size 256 --preset bwh_biopsy.csv --seg --patch --stitch || fail "python fail"
SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >

DIR = $(shell basename ${PWD})
# Default - top level rule is what gets ran when you run just `make`
run-remote-make: .env
> mkdir -p out
> rsync -avzP --exclude=.git ${PWD} kt-gpu4.ijs.si:
> ssh kt-gpu4.ijs.si "cd ${DIR} && make rerun"
.PHONY: run-remote-make

rerun: out/pytorch_nn.sif
> sbatch train_multi_gpu.slurm
.PHONY: run-remote-make

out/pytorch_nn.sif: pytorch_nn.def
> singularity build --force out/pytorch_nn.sif pytorch_nn.def

kill-job:
> ssh kt-gpu4.ijs.si "scancel $(filter-out $@,$(MAKECMDGOALS))"
.PHONY: kill-job

.env:
> @echo "You can find your API key in your browser here: https://wandb.ai/authorize"
> @read -p "Paste an API key from your profile and hit enter, or leave empty to cancel: " api_key
> @if [ $${api_key} ]; then
>   @echo 'WANDB_NOTES="$${SLURM_JOB_NAME}-$${SLURM_JOB_ID}"' > .env
>   @echo 'WANDB_ENTITY="ijs-e8-nlp"' >> .env
>   @echo "WANDB_API_KEY=$${api_key}" >> .env
> fi
> @if [ ! -f .env ]; then
>   echo -e '\nPlease create .env file with the following content and try again:\n'
>   echo 'WANDB_NOTES="$${SLURM_JOB_NAME}-$${SLURM_JOB_ID}"'
>   echo 'WANDB_ENTITY="ijs-e8-nlp"'
>   echo 'WANDB_API_KEY=<YOUR API KEY>'
>   echo -e '\nYou can check you WandB key at: https://wandb.ai/authorize'
>   exit 1
> fi

clean:
> rm -rf out
> rm .env
.PHONY: clean

## How to run the code?
1) Add your public SSH key to your profile on [SLING](https://fido.sling.si).
2) Add an entry for kt-gpu4 to your `~/.ssh/config` file, should look like this:
   ```
   Host kt-gpu4.ijs.si
     User your_username_on_sling
     IdentityFile /location/to/your/private.key
   ```
3) Clone this repo to your computer.
4) Ensure you have the `make` program installed.
5) Run `make` from within the repo folder and follow the instructions.

# STREAMline Project

Welcome to the STREAMline project repository—the hub for cutting-edge technology and collaboration in the realm of Advanced Machine Learning. STREAMline stands for **SLURM's Technology and Repository Environment for Advanced Machine Learning**, representing our commitment to streamline and optimize machine learning workflows.

This repository is designed as a collaborative playground for discovering, integrating, and experimenting with new technologies aimed at enhancing the efficiency and effectiveness of machine learning experiments.

In our mission to revolutionize our machine learning pipeline, we've chosen to integrate the following powerful tools:

- [DVC](https://dvc.org/) - Data Version Control, a robust tool for managing complex data and model pipelines.
- [Weights & Biases](https://wandb.ai/) (WandB) - A versatile platform for experiment tracking.
- [Apptainer containers](https://apptainer.org/) - Containerization technology, vital for portability and reproducibility (formerly known as Singularity).

## SLURM 
To be able to work with large models and execute experiments on a large scale, one needs access to a High-Performance Computing (HPC) system. Luckily, as employees at JSI, we have access to the national HPC network through SLING (https://www.sling.si/sling/). To gain access, you need to contact ``barbara.krasovec@ijs.si`` and ``cc damjan.demsar@ijs.si``. Additional insights into SLURM can be found here: https://doc.sling.si/en/navodila/slurm/  

## Data Version Control (DVC)

Our workflow leverages DVC as a cornerstone for managing the life cycle of machine learning projects. DVC streamlines the formation of data pipelines and hyperparameter optimization along with the meticulous management of data and models.

Utilizing DVC, we aspire to achieve simplicity and reproducibility:

- A single command (`make`) shall suffice to run any experiment - it orchestrates data retrieval, preprocessing stages, and initiates the training process.
- Implementing DVC's compatibility with WebDAV allows for convenient dataset acquisition directly from NextCloud.
- DVC's configured storage integration (`kt-models`) on our network disk ensures sustainable and secure long-term storage of models and artifacts.

We are dedicated to maintaining our data and model security. Even though WandB offers support for data and model management, we consciously choose not to upload sensitive datasets and models to the cloud.

## Weights & Biases (WandB)

Weights & Biases provides us with an exceptional framework for tracking and managing our machine learning experiments. Its seamless integration allows for collaborative monitoring and analysis of model performance and experimental results.

By incorporating the WandB team ecosystem:

- All team members can readily access experiment results, fostering transparency and group analysis.
- We've integrated WandB with Slack to streamline our notifications—get instant updates when a training run concludes, or be alerted in case of any training disruptions.

## Apptainer Containers

Apptainer leads the way in ensuring that our software environments are well-packaged for both reproducibility and scalability:

- Apptainer's containerization technology simplifies and encapsulates our software requirements into portable containers that can be executed in diverse environments.
- These containers are designed to integrate seamlessly with SLURM, facilitating scalable deployment across academic computing networks and ensuring our experiments are both manageable and high-performing.

Here is a tutorial to get familiar with Singularity (https://github.com/SkBlaz/singularity-container-tutorial).

Overall, the STREAMline project is poised to refine the machine learning lifecycle from data procurement to model deployment. Our repository is a reflection of our commitment to embracing innovative solutions and fostering a collaborative community where best practices in machine learning can thrive.

Stay tuned as we continuously improve and expand our toolset to meet the evolving challenges of machine learning research and application. Feel free to contribute, suggest enhancements, and explore the ongoing work within the STREAMline project. Together, let's push the boundaries of what's possible in machine learning.

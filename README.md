# Using the lab distribution of miniconda3

miniconda directory location:
/opt/apps/labs/mblab/software/miniconda

  The conda config file is softlinked from the above filepath ./wustl_cluster_config to ../condarc

This is a lab wide installation of miniconda. It is implemented as a module and is the same as using a cluster wide module.

To load miniconda (which just gives you access to the program conda)

```ml miniconda``` or ```module load miniconda```

to create an environment in your $USER/.conda/envs directory (this will only be accessible to the $USER)

conda create <env name>

to create an environment in a directory which is available to the whole lab, do the following:

conda create -p /opt/apps/labs/mblab/software/miniconda/envs/your_env_name

In both cases, to activate the environment (you have to do this after you create it -- remember that creating the environment does not automatically activate it)

conda activate <env_name> 

If this throws an error with a message about "conda init <shell>", you can either follow those instructions or ignore it and instead and use

source activate <env_name>

all other conda create commands are the same (-python## specifies a python verison, etc)

## intended usage

It is considered best practice to make a new environment for any given project. If you begin developing a project on your local machine and have been working in an environment, you can use the following command to export the environment to a .yml:

conda env export > environment.yml

you can then take that environment.yml and use it to create a new environment on the cluster (or elsewhere):

conda env create -f environment.yml (note that the name of the environment should be at the top of the .yml)

or conda env create -f environment.yml -p /opt/apps/labs/mblab/software/miniconda/envs

if you wish to make the environment in the shared environmental space. If you do this, everyone in the lab will be able to load your environment by simply entering

conda activate (or source activate) <the_env_name_specified_in_the_yml>

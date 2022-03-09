#!/usr/bin/bash

# Setup conda so that you can log into a virtual machine and create your favorite
# environment. For example:
# mamba create -n seisbench --file https://raw.githubusercontent.com/Denolle-Lab/seisbench-jupyter/main/conda-linux-64.lock

# Need to run this as 'root' or with 'sudo' priviledges
echo "Configuring Azure Virtual Machine..."

# Install Conda/Mamba to manage Python environment
wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh
bash Mambaforge-Linux-x86_64.sh -b
rm Mambaforge-Linux-x86_64.sh

# Ensure that conda is located when logging in
echo ". ./mambaforge/etc/profile.d/conda.sh" > /etc/profile.d/init_conda.sh

echo "Done"

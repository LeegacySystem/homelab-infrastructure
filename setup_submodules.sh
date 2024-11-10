#!/bin/bash

# Initialize and update submodules
git submodule update --init --recursive

# Navigate to the Kubespray submodule
cd 01_kubespray_cluster_setup

# Enable sparse checkout
git config core.sparseCheckout true

cat > ../.git/modules/01_kubespray_cluster_setup/info/sparse-checkout <<EOL
ansible.cfg
setup.cfg
requirements.txt
cluster.yml
scale.yml
playbooks
roles
plugins
library
EOL

# # Clear all existing files in the working directory (BE CAREFUL, this removes untracked files)
# git reset --hard

# Apply the sparse checkout
git read-tree -mu HEAD

# Sync inventory file from root 
cd ..
bash ./sync-hosts.sh
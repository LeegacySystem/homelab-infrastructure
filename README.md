
# Homelab Infrastructure Setup

This repository provides the Ansible playbooks that I use to setup my home lab a Kubernetes cluster. 

It consists of two main phases:

1. **Pre-Cluster Setup**: Initial node/host setup with essential configuration and optimisations.
2. **Kubernetes Cluster Deployment**: Automated deployment of a Kubernetes cluster using Kubespray.

## Repository Structure

- **`00_precluster_setup`**: Contains Ansible playbooks for pre-cluster setup tasks, including:
  - OS upgrades
  - Package installation
  - Configuration for specialised nodes (e.g., Optiplex, NAS)
  - Basic file system mounting and kernel updates
  - See `00_precluster_setup/README.md` for detailed information on the tasks and roles.

- **`01_kubespray_cluster_setup`**: A folder containg a fork of the popular Kubespray repository. 
  - I use this directory to deploy and manage my Kubernetes cluster after pre-cluster setup is complete.
  - Follow the Kubespray documentation for specific instructions and configurations for deploying your cluster.
  - As kubespray is rather large and complex I use sparse checkout to pick only what I want

- **`sync-hosts.sh`**: A helper script to keep inventory files in sync across the two setup phases.
  - Copies the `hosts.yml` file from the root directory to both `00_precluster_setup/inventory/` and `01_kubespray_cluster_setup/inventory/`.
  - Run this script whenever you update `hosts.yml` in the root to propagate changes to both setup phases.

## Inventory Structure

The inventory file `hosts.yml` in the root directory defines host groups, IP addresses, and roles for all nodes in the cluster setup. This file is shared across both the pre-cluster and Kubespray setups to maintain consistency.

# Usage
```sh

# Clone the repo
git clone git@github.com:LeegacySystem/homelab-infrastructure.git
cd homelab-infrastructure

# Init the submodule and sync the root inventory
bash setup_submodules.sh

# Run the pre-cluster setup
cd 00_precluster_setup
ansible-playbook -i inventory/homecluster/hosts.yml setup.yml -b 

# Deploy the cluster
cd ../01_kubespray_cluster_setup
ansible-playbook -i inventory/homecluster/hosts.yml  -b cluster.yml

# Scale the cluser by adding a node
ansible-playbook -i inventory/homecluster/hosts.yml scale.yml -b
```
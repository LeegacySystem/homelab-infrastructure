# Pre-Cluster Setup Ansible Playbooks

These playbloks are heavily customised to my setup.

 The `00_precluster_setup` playbook is responsible for preparing the nodes before deploying the Kubernetes cluster via kubespray.


## Table of Contents
- [Overview](#overview)
- [Inventory Structure](#inventory-structure)
- [Playbooks](#playbooks)
  - [setup.yml](#setupyml)
  - [ansible_version.yml](#ansible_versionyml)
- [Roles](#roles)
  - [common](#common-role)
  - [optiplex](#optiplex-role)
  - [nas](#nas-role)
- [Usage](#Usage)

## Overview
This pre-cluster setup playbook checks the Ansible version and configures the following:
- Basic OS upgrades, kernel updates, and package installations on all nodes
- Specialized setup for Optiplex and NAS nodes, including directory creation and file system mounting.

## Inventory Structure
The inventory file `hosts.yml` defines the host groups and their variables. 

I maintain the `hosts.yml` at the root folder of this repo and sync to both ansible projects using the 'sync-hosts.sh' script

Summary of the key groups:
- **kube_node**: Kubernetes nodes
- **optiplex_node**: Optiplex-specific nodes
- **nas_node**: NAS-specific nodes
- **kube_control_plane** and **etcd**: Used later in cluster setup

Inventory files and group variables:
- **`inventory/hosts.yml`**: Defines host groups and IPs.
- **`inventory/group_vars/kube_node.yml`**: Defines OS version and common packages for `kube_node`.

## Playbooks

### setup.yml
The main playbook, `setup.yml`, performs the following:
1. **Ansible Version Check**:
   - Imports `ansible_version.yml` to verify the local Ansible version.
2. **Common Setup**:
   - Applies the `common` role to `kube_node` hosts, performing system upgrades, package installations, daily security updates and kernel updates.
3. **Optiplex Node Setup**:
   - Runs the `optiplex` role on the `optiplex_node` group to handle Optiplex-specific setup tasks.
4. **NAS Node Setup**:
   - Runs the `nas` role on the `nas_node` group to handle NAS-specific tasks, including directory creation, file system mounting, and `mergerfs` installation.

## Usage

```sh
# To run all tasks
ansible-playbook -i inventory/homecluster/hosts.yml setup.yml -b 

# To run only nas tasks
ansible-playbook -i inventory/homecluster/hosts.yml setup.yml -b --tags nas
```
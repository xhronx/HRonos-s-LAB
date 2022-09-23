#! /bin/bash
# --extra-vars use for ansible

ansible-playbook plb1.yml -e "MYHOSTS=staging"

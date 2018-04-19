#!/bin/bash -l

yum install -y ansible
ansible --version

mkdir -p /app/data/ansible/hosts/ && mkdir -p /app/data/ansible/playbooks/

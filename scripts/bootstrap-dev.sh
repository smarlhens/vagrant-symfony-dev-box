#!/bin/bash

set -e
export DEBIAN_FRONTEND=noninteractive

echo "Installing Ansible..."
apt-get install -y software-properties-common dirmngr --install-recommends
echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 93C4A3FD7BB9C367
apt update -y
apt install -y ansible
cp /vagrant/ansible/ansible.cfg /etc/ansible/ansible.cfg

apt-get install -y unzip zip

echo "cd /vagrant/" >> /home/vagrant/.bashrc

usermod -aG www-data vagrant

ansible-galaxy install -r /vagrant/ansible/requirements/requirements.dev.yml -p /etc/ansible/roles

PYTHONUNBUFFERED=1 ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook /vagrant/ansible/dev.yml -i /vagrant/ansible/hosts -c local

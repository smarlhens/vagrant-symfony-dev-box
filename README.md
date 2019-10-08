# Vagrant dev box for Symfony

## Table of Contents

- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Building your development environment](#building-your-development-environment)
- [Known issues](#known-issues)

---  

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development purpose.

### Prerequisites

What things you need to install the software and how to install them : 

* [Git](https://git-scm.com/)
* [Vagrant](https://www.vagrantup.com/) (tested with version [2.2.5](https://releases.hashicorp.com/vagrant/2.2.5/))

---
  
### Installation

1. Clone the git repository
   ```bash
   git clone https://github.com/smarlhens/vagrant-symfony-dev-box.git
   ```

1. Go into the project directory
   ```bash
   cd vagrant-symfony-dev-box/
   ```

1. Copy your **Symfony** project *(src, bin, assets, etc.)* inside the `symfony` folder

1. Check the virtualhost in `ansible/vars/dev/geerlingguy.nginx.yml`

1. The database configuration is in `ansible/vars/dev/geerlingguy.mysql.yml`

1. If you want to change **PHP** version, you need to edit `ansible/vars/dev/geerlingguy.php-versions.yml`

1. If you want to change NodeJS version or add new packages you need to edit `ansible/vars/dev/geerlingguy.nodejs.yml`

### Building your development environment

#### Vagrant 

To launch dev virtual machine :
```bash
vagrant up dev
```

You need to add ```--provision``` arguments to the command _if the VM was not provisioned before_.

**Note :** If you are under **Windows** I recommend that you **do not use Git Bash** but the **Cmd**.

Then you will need to connect to the Vagrant virtual machine :
```bash
vagrant ssh dev
```

We will now move on to the installation of the dependencies of the [Symfony project](#symfony-project).

---

#### Symfony project

Documentation :
* [Symfony](https://symfony.com/doc/current/index.html)
* [Composer](https://getcomposer.org/doc/)

##### Install dependencies

1. Composer

   ```bash
   composer install
   ```

##### Initialize project

1. Create database schema

   ```bash
   php bin/console doctrine:database:create
   ```

1. Execute all migration files that have not already been run

   ```bash
   php bin/console doctrine:migrations:migrate
   ```

1. *You can execute all the commands necessary to initialize your   project now. Each project has its own command list and I only present the basic requirements.*

1. Clear cache

   ```bash
   php bin/console c:c -e prod
   php bin/console c:w -e prod
   ```

   You will need to remove ```-e prod``` for both command if you want to clear dev cache.

---

##### Access your website

The Symfony project is now accessible at [http://10.100.100.100](http://10.100.100.100).


---

## Known issues

1. Installation/Update of Virtualbox Guest Additions fails *([source](https://github.com/dotless-de/vagrant-vbguest/issues/351))*

   ```bash
   E: Unable to locate package linux-headers-4.9.0-9-amd64
   E: Couldn't find any package by glob 'linux-headers-4.9.0-9-amd64'
   E: Couldn't find any package by regex 'linux-headers-4.9.0-9-amd6
   ```

   A [workaround]((https://github.com/dotless-de/vagrant-vbguest/issues/351#issuecomment-538096696)) was found and I implemented it. 
   > This problem may no longer be relevant. Feel free to remove the modifications and test on your environment.

1. Vagrant Does not Start RSync-Auto on Up or Reload *([source](https://github.com/hashicorp/vagrant/issues/10002))*

   A [workaround](https://github.com/hashicorp/vagrant/issues/10002#issuecomment-419503397) was found and I implemented it. 
   > This problem may no longer be relevant. Feel free to remove the modifications and test on your environment.
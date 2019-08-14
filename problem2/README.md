# Bootstrap instructions
Ansible control node is remote machine.
Virtual Machine to be set up is target machine.

1) Install Ansible on remote machine
2) Setup passwordless ssh from remote machine to target machine.
2.1) ssh-add .pem file (private key) of target machine
2.2) ssh ubuntu@target-machine-ip
3) add entry [devops] and target-machine ip to /etc/ansible/hosts file
4) git clone this repo
4) cd to problem2 directory
5) ansible-playbook setup-dev.yml
6) All services (mysql, tomcat, apache2) should be started and enabled.

# Assumptions
1) Added ppa repo which required port 443 to be open on vpc egress.
2) port 80 is opened for apt-get install
2) Tomcat 9 link is hardcoded and may change as minor releases happen
3) The requested ports on the services are the same as the default installation ports so no enforecements / change of config file is attempted. Ideally, this should be enfored for idempotency.

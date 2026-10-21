# Cloud1

Deploying a WordPress Website to the Cloud Using Ansible

## Run Ansible on Vagrant

1. Create SSH keys

```sh
ssh-keygen -t ed25519 -f vagrant-target/vagrant-home/files/cloud_ed25519
```

2. Start Vagrant

```sh
cd vagrant-target/vagrant-home
vagrant up
```

3. Enter the `playdoh` machine & run Ansible

```sh
vagrant ssh playdoh
cd playdoh/
ansible-playbook playbook/playdoh.yml --vault-password-file roles/install_inception/files/vault.key
```

4. Enjoy the Coconuts

```
https://192.168.56.111
```

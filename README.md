# Cloud1

Deploying a WordPress Website to the Cloud Using Ansible

## Run Ansible on Vagrant

1. Create SSH keys

```sh
ssh-keygen -t ed25519 -f resources/vagrant-home/files/cloud_ed25519
```

2. Start Vagrant

```sh
cd resources/vagrant-home
PLAYDOH_KEY="/path/to/ssh/key/" vagrant up
```

3. Enter the `playdoh` machine & run Ansible

```sh
vagrant ssh playdoh
cd playdoh/
ansible-playbook playbook/playdoh.yml --ask-vault-pass --limit <mytargets>
```

4. Enjoy the Coconuts

```
https://dohdoh.duckdns.org
```

## Start, Stop, Clean

### Restart the Server

```sh
ansible-playbook playbook/playdoh_up.yml --ask-vault-pass --limit <mytargets>
```

### Stop the Server

```sh
ansible-playbook playbook/playdoh_stop.yml --ask-vault-pass --limit <mytargets>
```

### Clean the Server

```sh
ansible-playbook playbook/playdoh_clean.yml --ask-vault-pass --limit <mytargets>
```

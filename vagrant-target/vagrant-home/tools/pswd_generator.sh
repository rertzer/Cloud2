#!/bin/sh

role_path="/home/vagrant/playdoh/roles/install_inception"

sql_pass=`head /dev/random | basenc --base64url | head -c 32`
sql_root_pass=`head /dev/random | basenc --base64url | head -c 32`
wp_pass=`head /dev/random | basenc --base64url| head -c 32`

sed -i "s/^sql_password:.*$/sql_password: ${sql_pass}/" ${role_path}/vars/main.yml
sed -i "s/^sql_root_password:.*$/sql_root_password: ${sql_root_pass}/" ${role_path}/vars/main.yml
sed -i "s/^wp_password:.*$/wp_password: ${wp_pass}/" ${role_path}/vars/main.yml

 ansible-vault encrypt ${role_path}/vars/main.yml --ask-vault-pass 
 chown vagrant:vagrant ${role_path}/vars/main.yml

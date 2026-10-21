VAGRANT_DIR := vagrant-target/vagrant-home
VAGRANT_KEY := $(VAGRANT_DIR)/files/cloud_ed25519
VAGRANT_PUB := $(VAGRANT_KEY).pub
VAULT_KEY_HOST := vagrant-target/playdoh/roles/install_inception/files/vault.key
VAULT_KEY_SYNC := $(VAGRANT_DIR)/files/vault.key

all: start

start: keygen
	@cd $(VAGRANT_DIR) && vagrant up

keygen:
	@rm -f $(VAGRANT_KEY) $(VAGRANT_PUB)
	@ssh-keygen -q -t ed25519 -f $(VAGRANT_KEY) -N ""
	@mkdir -p $(dir $(VAULT_KEY_HOST)) $(dir $(VAULT_KEY_SYNC))
	@rm -f $(VAULT_KEY_HOST) $(VAULT_KEY_SYNC)
	@key=$$(head -c 48 /dev/urandom | basenc --base64url | head -c 64); \
	printf '%s\n' "$${key}" > $(VAULT_KEY_HOST); \
	printf '%s\n' "$${key}" > $(VAULT_KEY_SYNC)

playdoh:
	@cd $(VAGRANT_DIR) && vagrant ssh playdoh -- -t 'cd /home/vagrant && exec bash -l'

pixie:
	@cd $(VAGRANT_DIR) && vagrant ssh pixie -- -t 'cd /home/vagrant && exec bash -l'

pete:
	@cd $(VAGRANT_DIR) && vagrant ssh pete -- -t 'cd /home/vagrant && exec bash -l'

clean:
	@cd $(VAGRANT_DIR) && vagrant halt || true

fclean:
	@cd $(VAGRANT_DIR) && vagrant destroy -f || true
	@rm -rf $(VAGRANT_DIR)/.vagrant
	@rm -f $(VAGRANT_KEY) $(VAGRANT_PUB)
	@rm -f $(VAULT_KEY_HOST) $(VAULT_KEY_SYNC)

re: fclean start

.PHONY: all start keygen playdoh pixie pete clean fclean re
VAGRANT_DIR := vagrant-target/vagrant-home
VAGRANT_KEY := $(VAGRANT_DIR)/files/cloud_ed25519
VAGRANT_PUB := $(VAGRANT_KEY).pub

all: start

start: keygen
	@cd $(VAGRANT_DIR) && vagrant up

keygen:
	@rm -f $(VAGRANT_KEY) $(VAGRANT_PUB)
	@ssh-keygen -q -t ed25519 -f $(VAGRANT_KEY) -N ""

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

re: fclean all

.PHONY: all start keygen playdoh pixie pete clean fclean re

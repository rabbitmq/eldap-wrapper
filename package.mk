APP_NAME:=eldap

UPSTREAM_GIT:=https://github.com/etnt/eldap.git
UPSTREAM_REVISION:=e309de4db4b78d67d623
WRAPPER_PATCHES:=eldap-appify.patch

ORIGINAL_APP_FILE:=$(CLONE_DIR)/ebin/$(APP_NAME).app

EBIN_BEAMS += $(EBIN_DIR)/ELDAPv3.beam

GENERATED_DIR:=$(CLONE_DIR)/generated

define package_targets

$(EBIN_DIR)/eldap.beam: $(CLONE_DIR)/src/ELDAPv3.hrl

$(EBIN_DIR)/ELDAPv3.beam $(CLONE_DIR)/src/ELDAPv3.hrl: $(CLONE_DIR)/src/ELDAPv3.asn
	@mkdir -p $(GENERATED_DIR) $(EBIN_DIR)
	$(ERLC) $(ERLC_OPTS) $(GLOBAL_ERLC_OPTS) -o $(GENERATED_DIR) $$<
	mv $(GENERATED_DIR)/ELDAPv3.beam $(EBIN_DIR)
	mv $(GENERATED_DIR)/ELDAPv3.hrl $(CLONE_DIR)/src

$(PACKAGE_DIR)+clean::
	rm -rf $(GENERATED_DIR) $(EBIN_DIR)

endef

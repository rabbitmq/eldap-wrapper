APP_NAME:=eldap

UPSTREAM_GIT:=https://github.com/etnt/eldap.git
UPSTREAM_REVISION:=e309de4db4b78d67d623
WRAPPER_PATCHES:=eldap-appify.patch

ORIGINAL_APP_FILE:=$(CLONE_DIR)/ebin/$(APP_NAME).app

GENERATED_DIR:=$(CLONE_DIR)/generated
ERLC_OPTS:=-I $(GENERATED_DIR)
INCLUDE_HRLS+=$(GENERATED_DIR)/ELDAPv3.hrl
EBIN_BEAMS+=$(GENERATED_DIR)/ELDAPv3.beam

define package_targets

$(CLONE_DIR)/src/ELDAPv3.asn: $(CLONE_DIR)/.done

$(GENERATED_DIR)/ELDAPv3.hrl $(GENERATED_DIR)/ELDAPv3.beam: $(CLONE_DIR)/src/ELDAPv3.asn
	@mkdir -p $(GENERATED_DIR)
	$(ERLC) $(ERLC_OPTS) $(GLOBAL_ERLC_OPTS) -o $(GENERATED_DIR) $$<

$(PACKAGE_DIR)+clean::
	rm -rf $(GENERATED_DIR) $(EBIN_DIR)

endef

AMD64_VMS := \
	devotee-vm \
	devotee-gui-vm \
	highroad-vm \
	woods-vm \
	woods-gui-vm \

ARM64_VMS := \
	villain-vm \
	villain-gui-vm \

.PHONY: $(AMD64_VMS) $(ARM64_VMS)

$(AMD64_VMS):
	nix-build vm.nix -A $$(echo $@ | sd '\-vm$$' '')

$(ARM64_VMS):
	@echo "!!!!!!!!!! Currently broken, can't build alsoft !!!!!!!!!!"
	nix-build vm.nix -A $$(echo $@ | sd '\-vm$$' '') --argstr system aarch64-linux

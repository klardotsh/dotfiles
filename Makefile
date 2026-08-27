.POSIX:

CHEZMOI ?= chezmoi
SOURCE_DIR = $$(pwd)
ROOT_SOURCE_DIR = $$(pwd)/root/etc
ROOT_CONFIG = $$(pwd)/root/.chezmoi.root.toml

.PHONY: bootstrap user-init user-status user-diff user-dry-run user-apply \
	user-add user-postapply system-status system-diff system-dry-run \
	system-apply system-add

bootstrap: user-init
	@$(MAKE) user-postapply
	@$(MAKE) system-apply

user-init:
	$(CHEZMOI) --source "$(SOURCE_DIR)" init --guess-repo-url=false

user-status:
	$(CHEZMOI) --source "$(SOURCE_DIR)" status

user-diff:
	$(CHEZMOI) --source "$(SOURCE_DIR)" diff

user-dry-run:
	$(CHEZMOI) --source "$(SOURCE_DIR)" apply --dry-run --verbose

user-apply: user-dry-run
	$(CHEZMOI) --source "$(SOURCE_DIR)" apply

user-add:
	@test -n "$(TARGET)" || { printf '%s\n' 'Set TARGET to a user target.' >&2; exit 2; }
	$(CHEZMOI) --source "$(SOURCE_DIR)" add "$(TARGET)"

user-postapply: user-apply
	@command -v curl >/dev/null 2>&1
	@command -v fish >/dev/null 2>&1
	@command -v git >/dev/null 2>&1
	@mkdir -p "$(HOME)/.tmux/plugins"
	@test -d "$(HOME)/.tmux/plugins/tpm" || git clone https://github.com/tmux-plugins/tpm "$(HOME)/.tmux/plugins/tpm"
	url=$$(awk '!/^#/ && NF { print; exit }' "$(SOURCE_DIR)/wallpaper.txt") && \
	test -n "$$url" && \
	curl -L -o "$(HOME)/.wallpaper" "$$url"
	if test "`uname -s`" = Darwin; then \
		curl -L -o "$(HOME)/bin/git-prompt.sh" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh; \
	fi
	nvim --headless +JetpackSync +qall
	@printf '%s\n' 'Disregard any "not synchronized" error from JetpackSync above.' >&2
	nvim --headless +TSUpdate +qall

system-status:
	@if command -v doas >/dev/null 2>&1; then \
		doas $(CHEZMOI) --source "$(ROOT_SOURCE_DIR)" --destination /etc --config "$(ROOT_CONFIG)" status; \
	elif command -v sudo >/dev/null 2>&1; then \
		sudo -E $(CHEZMOI) --source "$(ROOT_SOURCE_DIR)" --destination /etc --config "$(ROOT_CONFIG)" status; \
	else \
		printf '%s\n' 'system-status: neither doas nor sudo is available' >&2; exit 127; \
	fi

system-diff:
	@if command -v doas >/dev/null 2>&1; then \
		doas $(CHEZMOI) --source "$(ROOT_SOURCE_DIR)" --destination /etc --config "$(ROOT_CONFIG)" diff; \
	elif command -v sudo >/dev/null 2>&1; then \
		sudo -E $(CHEZMOI) --source "$(ROOT_SOURCE_DIR)" --destination /etc --config "$(ROOT_CONFIG)" diff; \
	else \
		printf '%s\n' 'system-diff: neither doas nor sudo is available' >&2; exit 127; \
	fi

system-dry-run:
	@if command -v doas >/dev/null 2>&1; then \
		doas $(CHEZMOI) --source "$(ROOT_SOURCE_DIR)" --destination /etc --config "$(ROOT_CONFIG)" apply --dry-run --verbose; \
	elif command -v sudo >/dev/null 2>&1; then \
		sudo -E $(CHEZMOI) --source "$(ROOT_SOURCE_DIR)" --destination /etc --config "$(ROOT_CONFIG)" apply --dry-run --verbose; \
	else \
		printf '%s\n' 'system-dry-run: neither doas nor sudo is available' >&2; exit 127; \
	fi

system-apply: system-dry-run
	@if command -v doas >/dev/null 2>&1; then \
		doas $(CHEZMOI) --source "$(ROOT_SOURCE_DIR)" --destination /etc --config "$(ROOT_CONFIG)" apply; \
	elif command -v sudo >/dev/null 2>&1; then \
		sudo -E $(CHEZMOI) --source "$(ROOT_SOURCE_DIR)" --destination /etc --config "$(ROOT_CONFIG)" apply; \
	else \
		printf '%s\n' 'system-apply: neither doas nor sudo is available' >&2; exit 127; \
	fi

system-add:
	@test -n "$(TARGET)" || { printf '%s\n' 'Set TARGET to a system target.' >&2; exit 2; }
	@if command -v doas >/dev/null 2>&1; then \
		doas $(CHEZMOI) --source "$(ROOT_SOURCE_DIR)" --destination /etc --config "$(ROOT_CONFIG)" add "$(TARGET)"; \
	elif command -v sudo >/dev/null 2>&1; then \
		sudo -E $(CHEZMOI) --source "$(ROOT_SOURCE_DIR)" --destination /etc --config "$(ROOT_CONFIG)" add "$(TARGET)"; \
	else \
		printf '%s\n' 'system-add: neither doas nor sudo is available' >&2; exit 127; \
	fi

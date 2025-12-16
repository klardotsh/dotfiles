# A great shell, and a decent prompt
brew 'fish'
brew 'starship'

# Editors
brew 'neovim'
brew 'helix'
brew 'micro'

# Resource monitors
brew 'htop'
brew 'bottom'
brew 'btop'

# Multiplexers
brew 'tmux'
brew 'zellij'

# Differs
brew 'colordiff'
brew 'difftastic' # AST-aware diffing
brew 'riff'

# Pagers
brew 'moor'

# Git and git accessories
brew 'git'
brew 'git-lfs'
brew 'git-crypt'
brew 'git-interactive-rebase-tool'
brew 'gitu'

# Networking stuff
brew 'openssh'
brew 'mosh' # udp-based mobile-network-friendly shells over ssh
brew 'curl'
brew 'xh' # human-friendly pretty http/json client

brew 'jq' # The original
brew 'jaq' # jq clone for json stuff: https://github.com/01mf02/jaq
brew 'yq' # jq, but YAML-ified
brew 'fzf' # find files and shell history fuzzily
brew 'thefuck' # cli mistake fixer
brew 'ripgrep' # grep replacement
brew 'fd' # find replacement
brew 'sd' # sed partial replacement
brew 'eza' # ls replacement
brew 'erdtree' # fancy tree replacement
brew 'glow' # another markdown renderer
brew 'lowdown' # markdown renderer
brew 'bat' # better file printer
brew 'ov' # a much better pager
brew 'direnv' # per-directory envvars
brew 'zoxide' # better directory changing
brew 'lnav' # log wrangling and paging
brew 'ouch' # better archive extraction
brew 'scc' # SLOC counter

# Auth and Security
brew 'aws-vault'
brew 'rbw'
# This is mostly a holdover from my Linux boxen and how I have
# git configured: GNU's PGP implementation, which I then hook
# to provide commit signing in git because more code forges
# support PGP key verification than SSH key verification still
# as of late 2023
brew 'gnupg2'

# Containerization things
brew 'skopeo'
brew 'crane'

# Language things
brew 'rustup'
brew 'bacon'
brew 'cargo-update'
brew 'cargo-nextest'

# Packaging things, since I do a lot of that...
brew 'rpm'

# Entertainment :)
brew 'pianobar'

# Make MacOS slightly less awful to use. The bar is painfully low.
if OS.mac?
	tap 'koekeishiya/formulae'
	brew 'skhd'
	cask 'amethyst'
	cask 'ghostty'

	# QoL for weird monitors and such
	cask 'betterdisplay'

	# Eye candy
	cask 'font-cascadia-code'
	cask 'font-iosevka'
end

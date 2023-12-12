# Editors and dev productivity things.
brew 'neovim'
brew 'helix'
brew 'micro'
brew 'htop'
brew 'tmux'
brew 'colordiff'
brew 'git'
brew 'git-lfs'
brew 'git-crypt'
brew 'openssh'
brew 'curl'
brew 'httpie' # human-friendly pretty http/json client
brew 'jaq' # jq clone for json stuff: https://github.com/01mf02/jaq
brew 'fzf' # find files and shell history fuzzily
brew 'thefuck' # cli mistake fixer
brew 'ripgrep' # grep replacement
brew 'fd' # find replacement
brew 'sd' # sed partial replacement
brew 'eza' # ls replacement
brew 'lowdown' # markdown renderer
brew 'bat' # better file printer
brew 'most' # slightly better pager... kinda
brew 'mosh' # udp-based mobile-network-friendly shells over ssh
brew 'direnv' # per-directory envvars

# This is mostly a holdover from my Linux boxen and how I have
# git configured: GNU's PGP implementation, which I then hook
# to provide commit signing in git because more code forges
# support PGP key verification than SSH key verification still
# as of late 2023
brew 'gnupg2'

# Unsure if needed on bare MacOS metal but: avoid storing AWS
# credentials in plain text - store them in MacOS keyring or
# an AES-encrypted file on disk instead!
brew 'aws-vault'

# Make MacOS slightly less awful to use. The bar is painfully low.
if OS.mac?
	tap 'koekeishiya/formulae'
	brew 'skhd'
	cask 'amethyst'
end

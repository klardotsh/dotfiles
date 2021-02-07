# klardotsh's dotfiles - nix-ified!

> Huge thanks to [@yrashk's configs](https://github.com/yrashk/nix-home) which
> served as a great reference when converting from my old mess of symlinked
> files to a NixOS+home-manager setup in Feb 2021!

Welcome to the 2021 flavor of this now-nearly-a-decade-old repo! The big change
this year (and indeed probably the biggest change *ever* for this repo) is that
I am now tracking more or less my entire system in Git, and not just selected
configs, thanks to NixOS. It should be pretty straightforward to replicate any
machine I own either onto bare metal, or into QEMU VMs, so if you want to truly
experience how I work, it's now possible to replicate it all! (WIP at time of
writing...)

Assuming you [have Nix installed](https://nix.dev/tutorials/install-nix.html):

- To test in a QEMU VM, clone this repo, pick a machine by hostname, and build
  it with `make ${KLARDOTSH_HOSTNAME}-vm`. You can then launch the QEMU VM with
  `./result/bin/run-${KLARDOTSH_HOSTNAME}-vm` and log in as `dummy` with no
  password. `sudo passwd j` to give me a password and `su - j` on over.

> Interactive machines may have a `-gui` build option to actually launch a QEMU
> GUI. Check `vm.nix` for all build targets.

- To run on bare metal, set up disks [as in the NixOS install
  guide](https://nixos.org/manual/nixos/stable/index.html#ch-installation), and
  generate a hardware config with `nixos-generate-config --root /mnt`. Save the
  generated `hardware-configuration.nix` in `/tmp` and throw away the
  `configuration.nix`. Then:

```sh
nix-env -i git envsubst
cd /mnt/etc/nixos
sudo git clone https://git.klar.sh/klardotsh/dotfiles --single-branch --branch ${DOTFILES_BRANCH:-master} .

# manually merge /tmp/hardware-configuration.nix and
# system-configurations/${KLARKLARDOTSH_HOSTNAME}-hardware.nix, to taste

sudo ./generate-configuration.sh
sudo nixos-install

# assuming all goes well...
sudo reboot
```

## What Gets Used

All interactive machines have been standardized to a bit of a fault around a
Wayland desktop with Sway, Waybar, Mako & co., Firefox, PulseAudio, Pipewire,
Neovim (though I'm slowly moving towards Kakoune), Alacritty, and a myriad of
generally-lightweight tools.

Currently, no servers actually run Nix.

## Hostname Decoder Wheel

- `devotee`, named after the [Panic! at the Disco song "LA
  Devotee"](https://en.wikipedia.org/wiki/LA_Devotee), was an Dell XPS
  13 9370 with an Intel i5-8250U, 16GB RAM, 256GB NVME, and the lower-DPI 1080p
  screen.

- `antarctica`, named after the [Modest Mouse album "The Moon and
  Antarctica"](https://en.wikipedia.org/wiki/The_Moon_%26_Antarctica), is a
  gaming rig, music production host, and server. Inside is an AMD Ryzen 2700X,
  32GB RAM, and an obscene amount of storage. It runs Gentoo for now, because I
  need to offload many of its server responsibilities to other machines before I
  can justify rebuilding its OS...

- `villain`, named after the [Queens of the Stone Age album
  "Villains"](https://en.wikipedia.org/wiki/Villains_(Queens_of_the_Stone_Age_album)),
  is a bit of a toy machine at the moment, a Lenovo Yoga C630 WOS laptop powered
  by a Qualcomm Snapdragon 850, 8GB RAM, and 128GB of eMMC storage. Thanks to
  the [aarch64-laptops](https://github.com/aarch64-laptops/build) project for
  making this thing by and large usable! It runs a very broken Gentoo build for
  now, because I haven't ported the aarch64-specific userspace utils and patched
  kernel to Nix yet.

- `vermillion`, named after the [Slipknot song of almost the same name, except I
  can't spell](https://en.wikipedia.org/wiki/Vermilion_(song)), is a rarely-used
  2017 Samsung Chromebook Pro, running [Mr. Chromebox's coreboot
  firmware](https://mrchromebox.tech/) and Void Linux x86\_64-musl. It is unique
  in that it is the only machine running
  [sndio](https://en.wikipedia.org/wiki/Sndio) instead of PulseAudio or similar.
  This would be even more noteworthy if the machine actually had reliable sound
  support in the kernel at all...

### Retired

- `snowcone` is reserved for re-use because I love the name, but got rid of the
  machine it was attached to. TBA.

- Countless "legacy" machines you may find allusions to deep in the Git log... a
  few desktops, Chromebooks, Macbooks, and who knows what else. You almost
  certainly won't care about these.


## Replicating This Setup

### GTK/QT Themes

I use Ayu Dark all around. The GTK theme is [@dnordstrom's fork of
Arc](https://github.com/dnordstrom/ayu-theme/tree/ayu). The QT5 theme is Kvantum
by way of `qt5ct`, with [@dnordstrom's
stylesheet](https://github.com/dnordstrom/dotfiles/tree/master/kvantum). Both of
those you should pull from his repos and install wherever is appropriate - as
far as I can tell, Kvantum expects a system-wide install (so just use Daniel's
`install.sh`), but since GTK will happily use local themes, we can install it to
our homedir:

```sh
cd path/to/ayu-theme

# --with-gnome=3.22 is the upstream-recommended hack for 3.24+ ¯\_(ツ)_/¯
./autogen.sh --prefix=~/.local/ --with-gnome=3.22 --disable-light\
	--disable-cinnamon --disable-gnome-shell --disable-metacity --disable-unity\
	--disable-xfwm
```

### Firefox

[firefox-gnome-theme](https://github.com/rafaelmardojai/firefox-gnome-theme)

### Fonts

- [FSD Emoji](https://fsd.it/shop/fonts/fsd-emoji/), a paid emoji font by
  Fabrizio Schiavi
- [PT Sans](https://company.paratype.com/pt-sans-pt-serif), which is a libre
  font that comes as part of `media-fonts/paratype` on Gentoo,
  `google-fonts-ttf` on Void, and probably something similar to one of those on
  your distribution
- `fontawesome`: mostly tested against v4, but v5 may partially work

#### Infinality

Optional, but since I use it on at least some machines:

```
(snowcone) ~  » sudo eselect fontconfig enable 52-infinality.conf

(snowcone) ~  » eselect infinality list
Available styles:
  [1]   debug
  [2]   infinality *
  [3]   linux
  [4]   nyx
  [5]   osx
  [6]   osx2
  [7]   win7
  [8]   win98
  [9]   winxp

(snowcone) ~  » eselect lcdfilter list
Available styles:
  [1]   custom
  [2]   default
  [3]   infinality *
  [4]   infinality-classic
  [5]   infinality-nudge
  [6]   infinality-push
  [7]   infinality-sharpened
  [8]   infinality-shove
  [9]   ipad
  [10]  linux
  [11]  nyx
  [12]  osx
  [13]  ubuntu
  [14]  vanilla
  [15]  windows-7
  [16]  windows-7-light
  [17]  windows-xp
  [18]  windows-xp-light
```

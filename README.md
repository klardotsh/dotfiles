# klardotsh's dotfiles

In here you'll find my configs for just about everything I use on a daily basis
that has an exportable text-based config (that I've bothered to actually
configure). I'm planning to restructure the repo a bit to handle device-specific
configs in a more sane manner, but for now, here ya go.

In general, everything is standardized across all machines. There are very
rarely exceptions, and those exceptions tend to be handled with either something
along the lines of `include <hostname>.conf`, or by an outright duplicate config
file. Everything runs Sway, Waybar, Mako, Alacritty, Rofi, Firefox, Kakoune
and/or Neovim, and (with one exception) PulseAudio + pulsemixer. Most heavy
lifting happens on `antarctica` and is accessed with heavy use of `mosh` and
`tmux` and/or `abduco`.


## Hostname Decoder Wheel

- `snowcone`, named after [the deadmau5
  song](https://en.wikipedia.org/wiki/Snowcone_(instrumental)), is my primary
  machine. It is an HP Spectre 14 powered by an Intel i7-1165G7, 16GB RAM, 32GB
  of Optane, 1TB SSD, and a 3000x2000 OLED panel I'm sure I'll manage to burn in
  some day. Hopefully by then, OEMs will start making AMD laptops with actual
  premium externals (ports, display panels, etc) 😀

- `antarctica`, named after the [Modest Mouse album "The Moon and
  Antarctica"](https://en.wikipedia.org/wiki/The_Moon_%26_Antarctica), is a
  gaming rig, music production host, and server. Inside is an AMD Ryzen 2700X,
  32GB RAM, and an obscene amount of storage. It runs Gentoo.

- `villain`, named after the [Queens of the Stone Age album
  "Villains"](https://en.wikipedia.org/wiki/Villains_(Queens_of_the_Stone_Age_album)),
  is a bit of a toy machine at the moment, a Lenovo Yoga C630 WOS laptop powered
  by a Qualcomm Snapdragon 850, 8GB RAM, and 128GB of eMMC storage. Thanks to
  the [aarch64-laptops](https://github.com/aarch64-laptops/build) project, it
  kinda-sorta runs Void Linux aarch64-musl.

- `vermillion`, named after the [Slipknot song of almost the same name, except I
  can't spell](https://en.wikipedia.org/wiki/Vermilion_(song)), is a rarely-used
  2017 Samsung Chromebook Pro, running [Mr. Chromebox's coreboot
  firmware](https://mrchromebox.tech/) and Void Linux x86\_64-musl. It is unique
  in that it is the only machine running
  [sndio](https://en.wikipedia.org/wiki/Sndio) instead of PulseAudio or similar.
  This would be even more noteworthy if the machine actually had reliable sound
  support in the kernel at all...

### Retired

- `devotee`, named after the [Panic! at the Disco song "LA
  Devotee"](https://en.wikipedia.org/wiki/LA_Devotee), was an Dell XPS
  13 9370 with an Intel i5-8250U, 16GB RAM, 256GB NVME, and the lower-DPI 1080p
  screen, running Gentoo.

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

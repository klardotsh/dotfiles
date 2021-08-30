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

- `woods`, named after the [Bon Iver song by that
  name](https://en.wikipedia.org/wiki/Blood_Bank_(EP)), is my general purpose
  workstation powered by an AMD Ryzen 3900X, 32GB RAM, 1TB of SSD, and a Vega
  56. It runs Void Linux (glibc).

- `devotee`, named after the [Panic! at the Disco song "LA
  Devotee"](https://en.wikipedia.org/wiki/LA_Devotee), was an Dell XPS
  13 9370 with an Intel i5-8250U, 16GB RAM, 256GB NVME, and the lower-DPI 1080p
  screen. It runs Void Linux (musl).

- `highroad`, named after the [Mastodon song by that
  name](https://en.wikipedia.org/wiki/High_Road_(Mastodon_song)), is a NixOS
  router running on some cheap Dell thing I picked up at
  [RE-PC](http://www.repc.com/). Apparently it runs an i3-4170 and 8GB RAM.
  Neat.

- `sappy`, named after the [Nirvana song by that
  name](https://en.wikipedia.org/wiki/Sappy), is a headless server box (hosting
  things like Git, Minecraft, etc.), powered by an AMD Ryzen 2700X and 32GB
  RAM. It runs NixOS.

- `otherside`, named after the [Red Hot Chili Peppers song by that
  name](https://en.wikipedia.org/wiki/Otherside) is a NAS, powered by whatever
  random parts I had lying around the house, which apparently included an Intel
  i5-6600k and 32GB of almost certainly mismatched RAM. It has a few tens of
  terrabytes of storage in multiple ZFS pools, and runs Alpine Linux.

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

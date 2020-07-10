# klardotsh's dotfiles

In here you'll find my configs for just about everything I use on a daily basis
that has an exportable text-based config (that I've bothered to actually
configure). I'm planning to restructure the repo a bit to handle device-specific
configs in a more sane manner, but for now, here ya go.

In general, everything is standardized across all machines. There are very
rarely exceptions, and those exceptions tend to be handled with either something
along the lines of `include <hostname>.conf`, or by an outright duplicate config
file. Everything runs Sway, Waybar, Mako, Alacritty, Rofi, Firefox, Neovim, and
(with one exception) PulseAudio + pulsemixer. Most heavy lifting happens on
`antarctica` and is accessed with heavy use of `mosh` and `abduco` (a session
management / TUI detachment utility that does the only thing I cared about from
`tmux`).

The hostnames you may stumble across are generally named after music:

- `antarctica`, named after the [Modest Mouse album "The Moon and
  Antarctica"](https://en.wikipedia.org/wiki/The_Moon_%26_Antarctica), is my
  desktop and primary machine. Inside is an AMD Ryzen 2700X, 32GB RAM, and an
  obscene amount of storage. It runs Void Linux x86\_64-musl.

- `devotee`, named after the [Panic! at the Disco song "LA
  Devotee"](https://en.wikipedia.org/wiki/LA_Devotee), is my laptop, a Dell XPS
  13 9370 with an Intel i5-8250U, 16GB RAM, 256GB NVME, and the lower-DPI 1080p
  screen. It runs Void Linux x86\_64-musl.

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

To replicate the theming here, since `~/.local/share/themes` is not tracked,
you'll want to pull this repo, import the current wallpaper (tracked in
wallpaper.txt) and the current colorscheme (tracked in colorscheme.txt) into
[wpgtk](https://github.com/deviantfero/wpgtk), and... hope for the best? I
always use color 1 as the primary color, giving the red highlights, and
otherwise run mostly a stock wpgtk config.

Fonts-wise, to exactly replicate the setup, you'll need to buy
[PragmataPro](https://fsd.it/shop/fonts/pragmatapro/) and [FSD
Emoji](https://fsd.it/shop/fonts/fsd-emoji/), two wonderful fonts by Fabrizio
Schiavi, and download the free font [PT
Sans](https://company.paratype.com/pt-sans-pt-serif), which is included with the
`google-fonts-ttf` package on Void Linux (many other distributions ship a
similar or identical bundle). You'll also need Font Awesome v4 (which is
packaged as `font-awesome` on Void Linux and a few other distributions). This
Waybar config explicitly will **not** work correctly with Font Awesome v5.

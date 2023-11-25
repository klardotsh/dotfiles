# klardotsh's dotfiles

In here you'll find my configs for just about everything I use on a daily basis
that has an exportable text-based config (that I've bothered to actually
configure). I'm planning to restructure the repo a bit to handle
device-specific configs in a more sane manner, but for now, here ya go.

In general, everything is standardized across all machines. There are very
rarely exceptions, and those exceptions tend to be handled with either
something along the lines of `include <hostname>.conf`, or by an outright
duplicate config file. Everything runs sway, swaybar + i3status-rust, Mako,
foot, fuzzel, Firefox ESR, Neovim, and Pipewire. 

## One-liner to set "most" of this up

> **WARNING** This script is meant to be used only by me, or by folks who want
> to run more or less exactly my setup. It also makes assumptions like that
> you're willing to have `~/.config` be a symlink to this Git repository. Did I
> mention: **this Git repository**, meaning to manage your own configs in Git
> after using that move in script, you'd have to be running a Git-official fork
> of my dotfiles. This probably isn't what you want, but if it is, I guess I'm
> honored? Otherwise, use the script, found in
> [`bin/move-in.sh`](bin/move-in.sh) as inspiration, and don't `curl` it.

```sh
curl -L https://git.sr.ht/~klardotsh/dotfiles/blob/master/bin/move-in.sh | bash
```

## Hostname Decoder Wheel

For many years, all of my machines have been named after various songs, albums,
etc. Here's the current listing (see also: [my Uses
page](//klar.sh/uses.html)).

- `snowcone`, named after [a deadmau5 song by that
  name](https://www.youtube.com/watch?v=amBBO4PqJKo), is my general-purpose
  workstation, running Void Linux x86\_64-musl. It's powered by an AMD Ryzen
  7900, 96GB RAM, 2TB of SSD, and an RX 7600.

- `nocturnes`, named after [the Silicone Soul song "Les
  Nocturnes"](https://www.youtube.com/watch?v=hGvZWnVYfko) (that name refers to
  ["nocturne"](https://en.wikipedia.org/wiki/Nocturne)), is my primary laptop:
  a Thinkpad X13 Gen 4 AMD, again running Void Linux x86\_64-musl. It's powered
  by an AMD Ryzen 7840U, 32GB RAM, 1TB of SSD, and a Radeon 780M iGPU.

- `vermillion`, named after the [Slipknot song of almost the same name, except
  I can't spell](https://www.youtube.com/watch?v=xKcbYUwmmlE), is my outgoing
  laptop, a 2017 Samsung Chromebook Pro, running [Mr. Chromebox's coreboot
  firmware](https://mrchromebox.tech/) and Void Linux x86\_64-musl. Between
  early 2022 and late 2023, it was my sole laptop, after the death of
  `devotee`, below (an XPS 13 9370).

- `villain`, named after the [Queens of the Stone Age album
  "Villains"](https://en.wikipedia.org/wiki/Villains_(Queens_of_the_Stone_Age_album)).
  is a bit of a project car at the moment. It's a Lenovo Yoga C630 WOS laptop
  powered by a Qualcomm Snapdragon 850, 8GB RAM, and 128GB of eMMC storage. I
  boot it about once a year, but some configs here still refer to it so it's
  not retired yet...

Various names of past gear have been retired, but you may still see their names
here (and almost certainly in the Git history). Here's a grab and go list of
their namesakes:

- `woods`, named after [the Bon Iver song by that
  name](https://www.youtube.com/watch?v=MUGKbuWMqgU).

- `devotee`, named after [the Panic! at the Disco song "LA
  Devotee"](https://www.youtube.com/watch?v=r5dNcKTcnPA).

- `highroad`, named after [the Mastodon song by than
  name](https://www.youtube.com/watch?v=6Aw1WnNVcYw).

- `sappy`, named after [the Nirvana song by that
  name](https://www.youtube.com/watch?v=jOg8IblMNK4).

- `otherside`, named after the [Red Hot Chili Peppers song by that
  name](https://www.youtube.com/watch?v=rn_YodiJO6k).

# klardotsh's dotfiles

In here you'll find my configs for just about everything I use on a daily basis
that has an exportable text-based config (that I've bothered to actually
configure). I'm planning to restructure the repo a bit to handle device-specific
configs in a more sane manner, but for now, here ya go.

## Devices
While almost all of my dotfiles are universal across my devices, there's a few
references to specific hostnames. Here's the magical decoding ring:

### gravity

This is my beast of a desktop/server combo, used for (in no particular order)
F/OSS development, music production, gaming, streaming said games, and storing
tons of data.

Hardware:
- AMD Ryzen 2700X at ~4.6GHz overclock
- 32GB DDR4-3200
- Combined total of ~9TB storage across several SSDs and a 3x3TB ZFS RAID-Z1
  array
- Way too many pixels. tl;dr 3440x1440 @ 34" + 1600x1200 @ 12"

Software:
- Arch Linux (stock kernel)
- Usually `sway`, `waybar`, and `mako`, for a Wayland environment
- Sometimes I'll fall back to `i3`, `polybar`, and `notify-osd`, for an Xorg
  environment (most commonly this means I'm streaming, since OBS doesn't usually
  play nicely with wlroots compositors, though this is very slowly changing)
- For gaming: Steam w/native lib overrides, Lutris to manage Guild Wars 2, and
  MultiMC to manage a million instances of Minecraft
- For music: Bitwig Studio (almost always the 3.0 betas at time of writing),
  Carla, Airwave Manager, and uncountable synths/patches/etc. This machine uses
  PulseAudio in realtime mode with aggressive latency settings (see
  `.config/pulse/`), rather than JACK, and the experience is, shockingly enough,
  far nicer than dealing with JACK, especially given the machine is used for
  non-music purposes as well

### rain

This is my primary laptop, a Dell XPS 9370 FHD 16GB, mostly used at work.

The software stack is kept almost identical to `gravity`'s casual/development
stacks: `sway`, `waybar`, `mako`, etc.

### glados

Samsung Chromebook Pro dual-booted between ChromeOS (convenient Netflix machine
and glorified PDF reader mostly used for FIRST game manuals, if we're being
honest) and Arch Linux. This machine probably averages a few weeks of uptime a
year at best, it's truly a niche sidearm machine (though for a stretch of
several months it was my primary personal laptop, thus the Arch partition).

In Arch, the software stack is kept almost identical to `gravity`'s
casual/development stacks: `sway`, `waybar`, `mako`, etc. In ChromeOS, it's
all stock aside from having a root shell available.

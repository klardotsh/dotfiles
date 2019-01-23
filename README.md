# klardotsh's dotfiles

In here you'll find my configs for just about everything I use on a daily basis
that has an exportable text-based config (that I've bothered to actually
configure). I'm planning to restructure the repo a bit to handle device-specific
configs in a more sane manner, but for now, here ya go.

## Devices
While almost all of my dotfiles are universal across my devices, there's a few
references to specific hostnames. Here's the magical decoding ring:

### spoonman
This is my by far most heavily-used machine. It's my daily driver at work, and
sees a fair bit of use at home as well. Hardware-wise, it's a Dell XPS 13 (9370)
with an i5-8250U, 16GB RAM, and an internal panel resolution of 1920x1080. At
work, it's plugged into a Pluggable USB-C dock, various peripherals, and a
curved Dell 3440x1440 monitor. Software-wise, it runs Sway (Wayland) on Arch
Linux - though I may end up back on i3 (Xorg) to match the desktop (below).

### gravity
This is The Beast, my desktop. Ryzen 2700X at 4.2GHz, 32GB DDR4-3200, Vega 56,
3440x1440+2560x1080 screens. Running i3 (Xorg) on Arch Linux. It was named after
the fantastic Bullet For My Valentine album I had playing when I realized this
machine, at the time, had no hostname, several months after being installed.
Oops.

Other interesting software on this rig are mostly related to gaming and/or
streaming: Lutris, DXVK, OBS, etc. Yes, I can run just about any Windows game on
here, and I play Overwatch "competitively" on it.

### glados
This is by far my least-used but arguably most interesting device, and as such
it serves as my testbed for new configs pretty often. This is a Samsung
Chromebook Pro from 2017 (m3-6Y30, 4GB RAM) dual-booted with ChromeOS (running
the wonderful [MrChromebox firmware](https://mrchromebox.tech/) - albeit a
wildly out-of-date version from 2017). More interestingly than those lackluster
specs, it has a 2400x1600 (3:2 aspect!) display (in a 12" machine), a
touchscreen, and a Wacom-compatible pen layer. If something works on this
machine, it will work wonderfully on the others (and about 5x faster...)

Software-wise, this machine currently runs Sway (Wayland) on Arch Linux
(GalliumOS kernel 4.16), [Waybar](https://github.com/Alexays/Waybar),
[Mako](https://github.com/emersion/mako), and is definitely a work in progress.

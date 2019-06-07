# klardotsh's dotfiles

In here you'll find my configs for just about everything I use on a daily basis
that has an exportable text-based config (that I've bothered to actually
configure). I'm planning to restructure the repo a bit to handle device-specific
configs in a more sane manner, but for now, here ya go.

## Devices
While almost all of my dotfiles are universal across my devices, there's a few
references to specific hostnames. Here's the magical decoding ring:

### rain (formerly: spoonman)
A Dell XPS 9370 (i5, 16GB, FHD) running sway (Wayland) on Void Linux (musl),
named after my favorite weather condition (coincidentally, also the weather on
the day the machine was reinstalled with Void Linux. Not-as-coincidentally, also
very common weather in the Pacific Northwest).

When this machine was known as `spoonman`, it was the same hardware with Arch
Linux and, at different points, either AwesomeWM (Xorg), i3 (Xorg), or sway
(Wayland).

### gravity
This is The Beast, my desktop. Ryzen 2700X at 4.2GHz, 32GB DDR4-3200, Vega 56,
3440x1440+2560x1080 screens. Running Sway on Void Linux (glibc). It was named
after the fantastic Bullet For My Valentine album I had playing when I realized
this machine, at the time, had no hostname, several months after being
installed.  Oops.

Other interesting software on this rig are mostly related to gaming and/or
streaming: Lutris, DXVK, OBS, etc.

### glados
This is by far my least-used but arguably most interesting device, and as such
it serves as my testbed for new configs pretty often. This is a Samsung
Chromebook Pro from 2017 (m3-6Y30, 4GB RAM) dual-booted with ChromeOS (running
the wonderful [MrChromebox firmware](https://mrchromebox.tech/)). More
interestingly than those lackluster specs, it has a 2400x1600 (3:2 aspect!)
display (in a 12" machine), a touchscreen, and a Wacom-compatible pen layer. If
something works on this machine, it will work wonderfully on the others (and
about 5x faster...)

Software-wise, this machine currently runs sway (Wayland) on Arch Linux,
[Waybar](https://github.com/Alexays/Waybar),
[Mako](https://github.com/emersion/mako), and most of the rest of my "standard"
stack.

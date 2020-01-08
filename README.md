# klardotsh's dotfiles

In here you'll find my configs for just about everything I use on a daily basis
that has an exportable text-based config (that I've bothered to actually
configure). I'm planning to restructure the repo a bit to handle device-specific
configs in a more sane manner, but for now, here ya go.

## Devices
While almost all of my dotfiles are universal across my devices, there's a few
references to specific hostnames. Here's the magical decoding ring, and details
about the rigs themselves:

### antarctica

> Formerly named `gravity`

This is my beast of a desktop/server combo, used for (in no particular order)
F/OSS development, music production, gaming, streaming said games, and storing
tons of data.

Hardware:
- AMD Ryzen 2700X at ~4.0GHz overclock
- 32GB DDR4-3200
- Combined total of ~9TB usable storage across several SSDs and a 3x3TB ZFS
  RAID-Z1 array
- Dell 34" UltraSharp (3440x1440)
- Lots of instruments/MIDI controllers (this list changes more often than this
  README, stuff comes and goes):
    * [Ableton Push 2](https://www.ableton.com/en/push/)
    * [Conductive Labs NDLR](https://conductivelabs.com/)
    * [Akai Professional MPK249](https://www.akaipro.com/mpk249)
    * [Expressive E Touché](https://www.expressivee.com/buy-touche)
    * [Novation Launchpad MKII](https://novationmusic.com/launch/launchpad)
    * [Sixty Four Pixels' Le Strum](https://six4pix.com/product/lestrum/)
    * [ROLI Seaboard Block](https://roli.com/products/blocks/seaboard-block)
    * [Akai MPK Mini mkII](https://www.akaipro.com/mpk-mini-mkii)

Software:
- Gentoo Linux
- Usually `sway`, `waybar`, and `mako`, for a Wayland environment
- All audio is handled by JACK through a [fairly cheap Behringer
  interface](https://www.amazon.com/dp/B00QHURUBE) at 96kHz and "good enough"
  latency.
- For gaming: Steam w/native lib overrides, Lutris to manage Guild Wars 2, and
  MultiMC to manage a million instances of Minecraft
- For music production:
    * Bitwig Studio 3.0
    * Native VSTi: [Helm](https://tytel.org/helm/),
      [Vital](https://vital.audio/), [Cadmium](https://lhiaudio.com/), [Hive
      2](https://u-he.com/products/hive/),
      [Diva](https://u-he.com/products/diva/),
      [Surge](https://surge-synthesizer.github.io/),
      [ZynAddSubFX](http://zynaddsubfx.sourceforge.net/)
    * Other Native VSTs: [The whole AirWindows set](http://www.airwindows.com/),
      [Arch's vst-plugins group](https://www.archlinux.org/groups/x86_64/vst-plugins/)
    * I stopped bothering with Windows VSTs, but for the rare case I need one,
      [Airwave](https://github.com/psycha0s/airwave) is basically my only hope.
    * My Push 2 is enabled by
      [DrivenByMoss](https://github.com/git-moss/DrivenByMoss)

### devotee

> Formerly `spoonman` among others

This is my primary laptop, a Dell XPS 9370 FHD 16GB, mostly used at work.

The software stack is kept almost identical to `antarctica`'s casual/development
stacks: `sway`, `waybar`, `mako`, etc.

It currently runs Void Linux. The hostname inspiration is from [a Panic At The
Disco song](https://www.youtube.com/watch?v=r5dNcKTcnPA).

### villain

Lenovo Yoga C630 WOS - a Qualcomm SD850-based laptop with 8GB RAM, relying
heavily on the kernel development done by Linaro and others over at [their
GitHub org](https://github.com/aarch64-laptops/build). This machine is very much
a work in progress, unstable, and mostly a tinkerer's project/toy rig (it still
lacks WiFi, audio, reliable USB-C video, and OpenGL ES 3.3 support for
Alacritty, forcing me to currently use Termite).

This machine runs Gentoo, but most of its specialty configs (including
`/etc/portage/patches` tree) haven't made it into this repo yet.

### glados

Samsung Chromebook Pro with coreboot and Void Linux. This machine probably
averages a few weeks of uptime a year at best, it's truly a niche sidearm
machine (though for a stretch of several months it was my primary personal
laptop, for whatever reason).

The software stack is kept almost identical to `antarctica`'s casual/development
stacks: `sway`, `waybar`, `mako`, etc. The hostname predates the music theme,
and is of course a Portal reference.

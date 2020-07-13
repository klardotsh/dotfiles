# Answering the question, "What do Kodi and OPNsense have in common?"

This directory is siloed off from the others to specifically handle the weirdest
machine on the network, my HTPC+router box. The documentation here may be
lacking in some places, but whatever. This isn't meant to be beautiful, academic
English, it's the typed equivalent of scribbled napkin notes offered up to both
future Josh and to the world in hopes it is useful eventually.

## Pre-brief

Generating e-waste is bad, mkay? Especially when the box that would otherwise go
to waste is a perfectly-capable leftover [Alienware
Alpha](web.archive.org/web/https://www.dell.com/ng/p/alienware-alpha/pd)
(archive.org link just in case Dell discontinues the machine...). As such, the
box has been my home router (previously running pfSense) for a few years now. In
2020, when otherwise rewiring my home network and entertainment stand, I decided
it was time to banish the rooted Steam Link I'd been using as a Kodi box, and
merge the functionality into the (grossly overpowered) router box, by way of
virtualizing the router. This would further serve to stabilize the network, as
pfSense's Realtek drivers are...
[bad](https://www.reddit.com/r/PFSENSE/comments/9uitmr/realtek_driver_hell/),
and led me to tossing a "reboot when pings fail" script on cron, lest my network
go down due to `Watchdog Timeout` exceptions. Gross! Thankfully, Linux's drivers
are more stable, and we can pass a paravirtualized NIC through to the router.

## Installing the hypervisor

I used Gentoo from the [official Stage 4 Minimal
images](https://gentoo.osuosl.org/releases/amd64/autobuilds/current-stage4-amd64-minimal/).
The rough install guide here is: boot the install LiveCD and pretend you're
doing a normal stage 3 install: prepare the disks, mount `/mnt/gentoo` and
`/mnt/gentoo/boot`, and extract the stage4 tarball: `tar xvf stage4*.tar* -C
/mnt/gentoo --xattrs-include='*.*' --numeric-owner`. You'll need to chroot into
`/mnt/gentoo` and `emerge --sync` (web-rsync will not work) to ensure the
profile symlink actually resolves. I recommend editing `/etc/portage/make.conf`
at this point to set `GENTOO_MIRRORS`, `PORTAGE_NICENESS`,
`EMERGE_DEFAULT_OPTS`, `MAKEOPTS`, `GRUB_PLATFORMS`, `QEMU_USER_TARGETS`,
`INPUT_DEVICES`, and `VIDEO_CARDS` as appropriate for your system. Also, add
`elogind` (or `consolekit`, I haven't tested this but it *should* work) to
`USE`; it'll be needed as a transient dependency of `app-emulation/libvirt`.

> I tried a few times to get away with not building a kernel for this box - either
> by using the kernel that came with the stage4, or by copying the kernel from the
> LiveCD. Neither was ultimately suitable for this box, and I wound up building a
> kernel anyway (the config, a living document of sorts, is in `etc/kernels`).

Next, install everything we'll need to get this system off the ground (I believe
this was everything; I'm working from memory here):

```sh
emerge -uavDn \
	@world \
	sudo \
	bridge-utils \
	eselect-repository \
	eix \
	genkernel \
	gentoo-sources \
	xinit \
	xterm \
	setxkbmap \
	xorg-server \
	openbox \
	menumaker \
	acct-group/libvirt \
	app-emulation/libvirt \
	app-emulation/virt-viewer \
	app-emulation/virt-manager
```

Modify `/etc/genkernel.conf` to auto-configure grub2 after successful kernel
builds, and `genkernel --menuconfig` a kernel (near-defaults are basically okay
as long as your NIC is supported and all of the KVM, TUN/TAP, and VLAN tagging
options are enabled and your filesystem supported - feel free to borrow or base
off of my config).

Configure your network in `/etc/conf.d/net` to have a bridge per NIC you plan to
pass to OPNsense, and a `null` config on all bridges and related NICs. In my
case, I was setting up a single-NIC router (using VLAN tagging and an external
Netgear managed switch to separate LAN and WAN traffic), so I had only `br0` and
`enp3s0` involved, and my config is here in git for reference. Adjust as
necessary, and if you plan to have network access on the hypervisor OS, ensure
that the NIC providing said access (perhaps a USB NIC?) is configured
appropriately.

## Installing OPNsense

> You'll need to have this ISO on the box either before configuring the bridge
> in the above step (ex. curl/elinks download), or, probably easier, by copying
> it via flash drive.

Due to quirks (?) in the `serial` images and/or in `virt-install`, you'll
unfortunately need the `dvd` image and some sort of GUI access to the hypervisor
system to complete this step, though only for a few minutes. This was a good
excuse to install X+Openbox anyway :)

```sh
sudo virt-install \
	--name=opnsense \
	--memory=2048 \
	--vcpus=2 \
	--cpu host-passthrough \
	--cdrom=/opt/OPNsense-20.1-OpenSSL-dvd-amd64.iso \
	--disk=size=10,bus=virtio \
	--network bridge:br0 \
	--vnc \
	--os-variant freebsd11.2
```

> Note: OPNsense recommends at least 1GB RAM and 8GB disk, so consider those
> your floor values, but otherwise there are few other restrictions on how you
> spin this VM up. The argument to `--cdrom` must, at least on Gentoo, be
> readable (and its directory scannable) by the `qemu` user, so out of sheer
> laziness I chucked it in `/opt` and `chmod 777`'d it.

I went with an all-defaults OPNsense install. When the machine reboots,
`virt-install` will banish the cdrom drive for us and we'll be booting off a
QCOW2 image stored at `/var/lib/virbirt/images/opnsense.qcow2`. At this point
you can walk through the CLI configuration tool over the VNC connection to get
LAN/WAN interfaces up (and VLAN tags, if needed). Eventually, you'll be able to
connect to the OPNsense Web UI from another box to finish the setup.

Ensure the VM will autostart on boot, and reboot the host OS to test that
everything will survive a reboot (by now, it should!), and then you're done!:

```sh
rc-update add libvirtd default
virsh autostart opnsense
reboot
```

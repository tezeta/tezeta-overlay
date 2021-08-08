

# tezeta-overlay

Tezeta's personal Gentoo overlay

Add via eselect-repository:
```
eselect repository enable tezeta
emaint sync -r tezeta
```

Add via layman:
```
layman -o https://raw.githubusercontent.com/tezeta/tezeta-overlay/master/tezeta-overlay.xml -f -a tezeta
```
Add manually to /etc/portage/repos.conf:
```
[tezeta]
location = /var/db/repos/tezeta
sync-type = git
sync-uri = https://github.com/tezeta/tezeta-overlay.git
```

## What's inside:

 - gtk3 pystopwatch (https://github.com/tezeta/pystopwatch)
 - nextcloud (appimage, qtwebengine not required)
 - nextcloud (git)
 - ampache (git)
 - nginx with mpeg_ts module support
 - xfce4 wmdock plugin, both old and new GTK+3 port
 - various WindowMaker dockapps
 - kvpm 0.9.10-r1
 - memtest86+ 5.31b
 - Renesas uPD72020x firmware v2.0.2.6
 - me_cleaner (https://github.com/corna/me_cleaner)
 - funiq, fuzzy unique (https://github.com/mjfisheruk/funiq)
 - ponymix, a CLI volume control for PulseAudio (https://github.com/falconindy/ponymix)
 - lockstate, a tray keylock status indicator (https://oldforum.puppylinux.com/viewtopic.php?t=110710)
 - Previous, a NeXT 68k hardware emulator (http://previous.alternative-system.com)
 - [Tenacity](https://github.com/tenacityteam/tenacity) and [Sneedacity](https://github.com/Sneeds-Feed-and-Seed/sneedacity), Audacity forks free from telemetry

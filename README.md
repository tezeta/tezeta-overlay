
  
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

<details>
  <summary></summary>
 - gtk3 pystopwatch (https://github.com/tezeta/pystopwatch)
 - nextcloud-desktop (appimage, qtwebengine not required/git)
 - xfce4 wmdock plugin, old and new GTK+3 port
 - xfce4 docklike-plugin (https://github.com/nsz32/docklike-plugin)
 - various WindowMaker dockapps
 - kvpm 0.9.10-r1
 - lockstate, a tray keylock status indicator (https://oldforum.puppylinux.com/viewtopic.php?t=110710)
 - Previous, a NeXT 68k hardware emulator (http://previous.alternative-system.com)
 - [Tenacity](https://github.com/tenacityteam/tenacity) and [Sneedacity](https://github.com/Sneeds-Feed-and-Seed/sneedacity), Audacity forks free from telemetry
 - ampache (git)
 - nginx with mpeg_ts module support
 - memtest86+ 5.31b
 - Renesas uPD72020x firmware v2.0.2.6
 - me_cleaner (https://github.com/corna/me_cleaner)
 - funiq, fuzzy unique (https://github.com/mjfisheruk/funiq)
 - ponymix, a CLI volume control for PulseAudio (https://github.com/falconindy/ponymix)
</details>                               


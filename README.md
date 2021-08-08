
  
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

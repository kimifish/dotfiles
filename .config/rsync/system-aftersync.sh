#!/bin/sh

/bin/chmod 755 /usr

/bin/chmod 755 /usr/lib
/bin/chmod 755 /usr/lib/systemd
/bin/chmod 755 /usr/lib/systemd/system
/bin/chmod 755 /usr/lib/systemd/user
/bin/chmod 644 /usr/lib/systemd/user/userfiles*
/bin/chmod 644 /usr/lib/systemd/system/systemfiles*

/bin/chmod 755 /usr/share
/bin/chmod 755 /usr/share/X11
/bin/chmod 755 /usr/share/X11/xkb
/bin/chmod 755 /usr/share/X11/xkb/symbols
/bin/chmod 644 /usr/share/X11/xkb/symbols/kimi

/bin/chmod 755 /etc

/bin/chmod 755 /etc/taskd
/bin/chmod 644 /etc/taskd/config

/bin/chmod 755 /etc/default
/bin/chmod 644 /etc/default/keyboard

/bin/chmod 755 /etc/kmscon
/bin/chmod 644 /etc/kmscon/kmscon.conf

/bin/chmod 755 /etc/netplan
/bin/chmod 644 /etc/netplan/00-installer-config.yaml

/bin/chmod 750 /root/.bashrc
/bin/chmod -R 750 /root/.bashrc.d

systemctl daemon-reload


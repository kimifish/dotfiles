#!/bin/sh

user=$1
p="/home/$user"

/bin/chmod 750 $p/.local/bin
/bin/chmod 644 $p/.config/rsync/*.lst
/bin/chmod 644 $p/.tmuxinator/*.yml
/bin/chmod 600 $p/*.ssh

/bin/chmod 750 $p
/bin/chmod 750 $p/bin
/bin/chmod 700 $p/.ssh
/bin/chmod 600 $p/.ssh/authorized_keys
/bin/chmod 640 $p/.bashrc
/bin/chmod 640 $p/.profile

systemctl --user daemon-reload


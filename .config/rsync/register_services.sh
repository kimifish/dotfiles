#!/bin/sh
#echo Copying system unit files...
#sudo cp ./systemfiles-* /usr/lib/systemd/system
USER=`whoami`
echo Copying user unit files...
sudo cp ./userfiles-* /usr/lib/systemd/user

#echo Enabling system units...
#sudo systemctl enable systemfiles-local2vault@kimifish.service
#sudo systemctl enable systemfiles-vault2local@kimifish.service
#sudo systemctl enable systemfiles-local2vault@kimifish.timer
#sudo systemctl enable systemfiles-vault2local@kimifish.timer

echo Enabling user units...
systemctl --user enable userfiles-local2vault@$USER.service
systemctl --user enable userfiles-vault2local@$USER.service
systemctl --user enable userfiles-local2vault@$USER.timer
systemctl --user enable userfiles-vault2local@$USER.timer

echo Reloading daemons...
#sudo systemctl daemon-reload
systemctl --user daemon-reload

echo Running services...
#sudo systemctl start systemfiles-vault2local@kimifish.service
systemctl --user start userfiles-vault2local@$USER.service

echo Starting timers...
systemctl --user start userfiles-local2vault@$USER.timer
systemctl --user start userfiles-vault2local@$USER.timer
#sudo systemctl start systemfiles-local2vault@kimifish.timer
#sudo systemctl start systemfiles-vault2local@kimifish.timer

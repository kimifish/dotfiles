#!/bin/sh
echo Copying system unit files...
sudo cp ./systemfiles-* /usr/lib/systemd/system
echo Copying user unit files...
sudo cp ./userfiles-* /usr/lib/systemd/user

echo Enabling system units...
sudo systemctl enable systemfiles-local2vault@kimifish.service
sudo systemctl enable systemfiles-vault2local@kimifish.service
sudo systemctl enable systemfiles-local2vault@kimifish.timer
sudo systemctl enable systemfiles-vault2local@kimifish.timer

echo Enabling user units...
systemctl --user enable userfiles-local2vault@kimifish.service
systemctl --user enable userfiles-vault2local@kimifish.service
systemctl --user enable userfiles-local2vault@kimifish.timer
systemctl --user enable userfiles-vault2local@kimifish.timer

echo Reloading daemons...
sudo systemctl daemon-reload
systemctl --user daemon-reload

echo Running services...
sudo systemctl start systemfiles-vault2local@kimifish.service
systemctl --user start userfiles-vault2local@kimifish.service

echo Starting timers...
systemctl --user start userfiles-local2vault@kimifish.timer
systemctl --user start userfiles-vault2local@kimifish.timer
sudo systemctl start systemfiles-local2vault@kimifish.timer
sudo systemctl start systemfiles-vault2local@kimifish.timer

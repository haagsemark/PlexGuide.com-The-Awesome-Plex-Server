#!/bin/bash
#
# [Ansible Role]
#
# GitHub:   https://github.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server
# Author:   Admin9705 & Deiteq
# URL:      https://plexguide.com
#
# PlexGuide Copyright (C) 2018 PlexGuide.com
# Licensed under GNU General Public License v3.0 GPL-3 (in short)
#
#   You may copy, distribute and modify the software as long as you track
#   changes/dates in source files. Any modifications to our software
#   including (via compiler) GPL-licensed code must also be made available
#   under the GPL along with build & install instructions.
#
#################################################################################
echo "on" > /var/plexguide/main.menu
menu=$(echo "on")

while [ "$menu" != "break" ]; do
menu=$(cat /var/plexguide/main.menu)
ansible-playbook /opt/plexguide/roles/menu-start/main.yml
menu=$(cat /var/plexguide/main.menu)

if [ "$menu" == "mount" ]; then
  echo 'INFO - Selected: Deploy a Mount System' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh

  edition=$(cat /var/plexguide/pg.edition.stored)
  if [ "$edition" == "PG Edition - HD Solo" ]; then
    echo ""
    echo "Utilizing the HD Solo Edition! Cannot Setup HDs!"
    echo "Note: Data Stored via the Solo HD @ /mnt"
    echo ""
    read -n 1 -s -r -p "Press [ANY] Key to Continue"
  elif [ "$edition" == "PG Edition - HD Multi" ]; then
    echo ""
    bash /opt/plexguide/roles/menu-multi/scripts/main.sh
  else
    bash /opt/plexguide/roles/menu-transport/scripts/main.sh
  fi

fi

if [ "$menu" == "traefik" ]; then
  echo 'INFO - Selected: Traefik & TLD' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh

  ### Affects Only Multi-HD and No Mount Is Deployed!
  multi=$(cat /var/plexguide/multi.unionfs)
  edition=$(cat /var/plexguide/pg.edition.stored)

  if [ "$edition" == "PG Edition - HD Multi" ] && [ "$multi" == "" ]; then
    echo ""
    echo "WARNING: You cannot proceed! Deploy one mount with UNIONFS first!"
    read -n 1 -s -r -p "Press [ANY] Key to Continue"
  else
    bash /opt/plexguide/roles/menu-tld/scripts/submenu.sh
  fi

fi

if [ "$menu" == "programs" ]; then
  echo 'INFO - Selected: PG Program Suite' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh

  ### Affects Only Multi-HD and No Mount Is Deployed!
  multi=$(cat /var/plexguide/multi.unionfs) 1>/dev/null 2>&1
  edition=$(cat /var/plexguide/pg.edition.stored) 1>/dev/null 2>&1

  if [ "$edition" == "PG Edition - HD Multi" ] && [ "$multi" == "" ]; then
    echo ""
    echo "WARNING: You cannot proceed! Deploy one mount with UNIONFS first!"
    read -n 1 -s -r -p "Press [ANY] Key to Continue"
  else
    bash /opt/plexguide/roles/programs/main.sh
  fi

fi

if [ "$menu" == "plextools" ]; then
  echo 'INFO - Selected: PLEX Enhancements' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
  bash /opt/plexguide/roles/menu-plexaddons/scripts/main.sh
fi

if [ "$menu" == "security" ]; then
  echo 'INFO - Selected: PG Security Suite' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
  bash /opt/plexguide/menus/security/main.sh
fi

if [ "$menu" == "tshoot" ]; then
  echo 'INFO - Selected: PG Server Information' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
  echo "tshoot" > /var/plexguide/type.choice && bash /opt/plexguide/menu/core/scripts/main.sh
fi

if [ "$menu" == "pgvpn" ]; then
  echo 'INFO - Selected: PG VPNServer' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
  echo vpnserver > /var/plexguide/type.choice && bash /opt/plexguide/menu/core/scripts/main.sh
fi

if [ "$menu" == "auditor" ]; then
  echo 'INFO - Selected: Auditor' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
  bash /opt/plexguide/roles/menu-network/scripts/main.sh
fi

if [ "$menu" == "backup" ]; then
  echo 'INFO - Selected: Backup & Restore' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh

  edition=$(cat /var/plexguide/pg.edition.stored)
  if [ "$edition" == "PG Edition - HD Solo" ]; then
    echo ""
    echo "Utilizing the HD Solo Edition! Cannot Backup or Restore!"
    echo "Note: This Version has No GDrive to Backup or Restore From!"
    echo ""
    read -n 1 -s -r -p "Press [ANY] Key to Continue"
  elif [ "$edition" == "PG Edition - HD Multi" ]; then
    echo ""
    echo "Utilizing the HD Multi Edition! Cannot Backup or Restore!"
    echo "Note: This Version has No GDrive to Backup or Restore From!"
    echo ""
    read -n 1 -s -r -p "Press [ANY] Key to Continue"
  else
    bash /opt/plexguide/roles/b-control/scripts/main.sh
  fi

fi

if [ "$menu" == "settings" ]; then
  echo 'INFO - Selected: Settings' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
  echo "settings" > /var/plexguide/type.choice && bash /opt/plexguide/menu/core/scripts/main.sh
fi

if [ "$menu" == "auth" ]; then
  echo 'INFO - Selected: Authentication Menu' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh

  ### Affects Only Multi-HD and No Mount Is Deployed!
  multi=$(cat /var/plexguide/multi.unionfs)
  edition=$(cat /var/plexguide/pg.edition.stored)

  if [ "$edition" == "PG Edition - HD Multi" ] && [ "$multi" == "" ]; then
    echo ""
    echo "WARNING: You cannot proceed! Deploy one mount with UNIONFS first!"
    read -n 1 -s -r -p "Press [ANY] Key to Continue"
  else
    bash /opt/plexguide/roles/menu-appguard/scripts/main.sh
  fi

fi

if [ "$menu" == "ports" ]; then
  echo 'INFO - Selected: Ports Interface' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh

  ### Affects Only Multi-HD and No Mount Is Deployed!
  multi=$(cat /var/plexguide/multi.unionfs)
  edition=$(cat /var/plexguide/pg.edition.stored)

  if [ "$edition" == "PG Edition - HD Multi" ] && [ "$multi" == "" ]; then
    echo ""
    echo "WARNING: You cannot proceed! Deploy one mount with UNIONFS first!"
    read -n 1 -s -r -p "Press [ANY] Key to Continue"
  else
    bash /opt/plexguide/roles/menu-ports/scripts/main.sh
  fi

fi

echo 'INFO - Looping: Main GDrive Interface Menu' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
done

echo 'INFO - Selected: Exiting PlexGuide' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
bash /opt/plexguide/roles/ending/ending.sh

#!/bin/bash
#
# [PlexGuide Menu]
#
# GitHub:   https://github.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server
# Author:   Admin9705 - Deiteq
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
domain=$( cat /var/plexguide/server.domain )
ipv4=$( cat /var/plexguide/server.ip )
program=$( cat /tmp/program )
port=$( cat /tmp/port )

dialog --title "$display - Address Info" \
--msgbox "\nIPv4      - http://$ipv4:$port\nSubdomain - https://$program.$domain\nDomain    - http://$domain:$port" 8 50

echo "INFO - $program Info - Port $port" > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh

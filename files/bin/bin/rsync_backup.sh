#!/bin/sh
rsync -aAXv -h --progress --partial --delete --exclude="dave10/Games/" --exclude="dave10/.cache/" /home /media/linuxdata/Backups

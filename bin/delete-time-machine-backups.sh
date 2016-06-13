#!/usr/bin/env bash

# See `tmutil' for options on manipulating Time Machine backups
#
#
# Get list of current backups:
#
#   tmutil listbackups > backups-to-delete.txt 
#
#
# Modify lines for those backups to be retained by prepending '#'
# e.g.
#
#   # keep - lines prepended with '#' are ignored
#   #/Volumes/Time Machine Backups/Backups.backupdb/Razor-iMac/2014-10-18-074407
#   /Volumes/Time Machine Backups/Backups.backupdb/Razor-iMac/2014-10-25-074821
#   #/Volumes/Time Machine Backups/Backups.backupdb/Razor-iMac/2014-11-01-075729
#   /Volumes/Time Machine Backups/Backups.backupdb/Razor-iMac/2014-11-08-004120
#   /Volumes/Time Machine Backups/Backups.backupdb/Razor-iMac/2014-11-18-205118
#
# 
# Process list of files with this script
# 
#   sudo delete-time-machine-backups.sh  backups-to-delete.txt
#


filelist=$1
if [ ! -s "$filelist" ]; then
  script=$(basename $0)
  echo "Usage: $script <file-with-backup-list>"
  exit 1
fi

# - filter out lines with '#'
# - wrap each line with quotes so xargs tokenizes arguments properly
grep -v '#' $filelist | \
  perl -pe 's/(.*)/"\1"/' | \
  xargs -n 1 tmutil delete


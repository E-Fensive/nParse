#!/bin/sh

# nparse 1.0
# Initially created for SBC logging via the (now defunct) VoIP Abuse Project

cd /usr/local/netrake/mp/logs

nlogs="/tmp/NetrakeAttacks"

[  ! -d "$nlogs" ] && { echo "$0: No log directory... Making it now"; mkdir /tmp/NetrakeAttacks ; exit 1; } 

# This keeps a record of the entries on file for the offending hosts.

grep "Unknown Customer" AlarmManager.log | awk '/9416|9442/{print $27}' | sort -u |\
awk -F / '{print $1}' | sort -u | while read these ; do echo "grep $these AlarmManager.log |\
awk '/9416|9442/{print \$11,\$21,\$22,\$23,\$27}' > $nlogs/$these" | sh ; done

# Go to our directory, sanitize garbage, create a list of offenders

cd $nlogs
perl -pi -e 's#,-05:00##g;s#\.0##g;s#,# #g;s#/1##g;s#/0##g;s#/1##g' *
ls > addresses.txt

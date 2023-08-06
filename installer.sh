#!/bin/bash

7z &>/dev/null
if [ "$?" != "0" ]
then
echo 7zip is not installed.
echo exiting..
exit 127
fi

if [ "$1" = "-h" ]
then
echo "Usage: $0 [-h/-u]"
echo "Install or uninstall (-u) vice emulator."
exit 0
fi

if [ "$(id -u)" != "0" ]
then
echo You must be root to run this program.
$0 -h
exit 0
fi

if [ "$1" = "-u" ]
then
echo Uninstalling...
sudo rm -rf /usr/local/share/vice /usr/local/bin/c1541 /usr/local/bin/vsid /usr/local/bin/x128 /usr/local/bin/x64 /usr/local/bin/x64dtv /usr/local/bin/x64sc /usr/local/bin/xcbm2 /usr/local/bin/xcbm5x0 /usr/local/bin/xpet /usr/local/bin/xplus4 /usr/local/bin/xscpu64 /usr/local/bin/xvic
exit 0
fi

_END_=$( awk '
  BEGIN { err=1; } 
  /^\w*___ZIBRI___\w*$/ { print NR+1; err=0; exit 0; } 
  END { if (err==1) print "?"; }
' "$0" )
echo Installing...
tmp=$(mktemp -d)
tail -n +$_END_ $0 >$tmp/vice.7z
7z &>/dev/null x -aoa -o/ "$tmp/vice.7z"
rm -rf "$tmp"
exit 0

___ZIBRI___

#!/bin/bash
upd=$(curl -qs https://api.github.com/repos/Zibri/VICE/releases|grep \"tag_name\"|grep o|tr -d \"_tagname:\ r\\\",\"|sort -nr|head -1|sed s/o/M/)
if ! [ "$(which x64sc)" ]
then
  myver="none"
else
  myver=$(strings $(which x64sc)|grep -B 1 "Current VICE"|head -n 1)
fi
if [[ "$upd" = "$myver" ]]
then
  echo No new version.
else
  echo "Downloading VICE latest version..."
  dlurl=$(curl -qs 'https://api.github.com/repos/Zibri/VICE/releases'|grep download_url|grep gtk|grep 'o/'|sort -nr|head -1|cut -d'"' -f 4)
  echo "Downloading update $upd..."
  curl -sL -o /tmp/viceup.sh "$dlurl"
  chmod a+x /tmp/viceup.sh
  sudo /tmp/viceup.sh -u
  sudo /tmp/viceup.sh
fi


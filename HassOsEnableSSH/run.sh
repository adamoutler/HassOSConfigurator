#!/usr/bin/with-contenv bashio

fun() {  while true; do nc -l -p 8099 -e  echo -e 'HTTP/1.1 200 OK\r\nServer: DeskPiPro\r\nDate:$(date)\r\nContent-Type: text/html; charset=UTF8\r\nCache-Control: no-store, no cache, must-revalidate\r\n\r\n<!DOCTYPE html><html><body><p>For some reason this improves security rating for Home Assistant, so I am using it.</body></html>\r\n\n\n'; done }; fun&

key=$(cat options.json |jq -r '.SSHKey')
until false; do
set +e
  mkdir /tmp 2>/dev/null
  mkdir /tmp/mmcblk0p1 /tmp/sda1 2> /dev/null
  if [ ! -e /dev/sda1 ] && [ ! -e /dev/mmcblk0p1 ]  && [ ! -e /dev/sdb1 ] ; then 
    echo "nothing to do. I can't find a /dev/sda1, /dev/sdb1, or /dev/mmcblk0p1";
    while true; do sleep 99999; done;
  fi;


  performWork () {
    partition=$1
    mount /dev/$partition /tmp/$partition 2>/dev/null
    if [ -e /tmp/$partition/cmdline.txt ]; then
      if [ $(grep "$key" /tmp/$partition/config.txt) ]; then
        echo "already added this key to $partition";
        return;
      fi;
      echo "creating authorized keys in $partition !"
      mkdir -p /tmp/$partition/CONFIG
      echo "$key">>/tmp/$partition/CONFIG/authorized_keys
    else
      echo "no $partition config found"
    fi
  }

  performWork sda1
  performWork sdb1
  performWork mmcblk0p1

  echo "This Configurator did it's job.  You can uninstall and reboot now.  This configurator only works once."
  sleep 99999;
done

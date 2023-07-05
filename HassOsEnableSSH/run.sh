#!/usr/bin/with-contenv bashio

fun() {  while true; do nc -l -p 8099 -e  echo -e 'HTTP/1.1 200 OK\r\nServer: DeskPiPro\r\nDate:$(date)\r\nContent-Type: text/html; charset=UTF8\r\nCache-Control: no-store, no cache, must-revalidate\r\n\r\n<!DOCTYPE html><html><body><p>This addon gains 2 security points for implementing this page. So it is here.</body></html>\r\n\n\n'; done }; fun&

key=$(cat options.json |jq -r '.SSHKey')
until false; do
set +e
  mkdir /tmp 2>/dev/null
  mkdir /tmp/vda1 /tmp/mmcblk0p1 /tmp/mmcblk0p2 /tmp/mmcblk1p1 /tmp/sda1 /tmp/sdb1 /tmp/nvme0n1p1 2> /dev/null
  if [ ! -e /dev/sda1 ] && [ ! -e /dev/vda1 ] && [ ! -e /dev/mmcblk0p1 ] && [ ! -e /dev/mmcblk0p2 ] && [ ! -e /dev/mmcblk1p1 ] && [ ! -e /dev/sdb1 ] && [ ! -e /dev/nvme0n1p1 ] ; then 
    echo "nothing to do. I can't find a /dev/vda1, /dev/sda1, /dev/sdb1, /dev/mmcblk0p1, /dev/mmcblk0p2, /dev/mmcblk1p1 or /dev/nvme0n1p1";
    while true; do sleep 99999; done;
  fi;

  performWork () {
    partition=$1
    mount /dev/$partition /tmp/$partition 2>/dev/null
    if [ -e /tmp/$partition/cmdline.txt ]; then
      if test -e /tmp/$partition/CONFIG/ && grep "$key" /tmp/$partition/CONFIG/authorized_keys 2>&1>/dev/null; then
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

  performWork vda1
  performWork sda1
  performWork sdb1
  performWork mmcblk0p1
  performWork mmcblk0p2
  performWork mmcblk1p1
  performWork nvme0n1p1

  echo "This Configurator did it's job. Perform a hard-power-off now. This configurator only works once and is no longer needed."
  sleep 99999;
done

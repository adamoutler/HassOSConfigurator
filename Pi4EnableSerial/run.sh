#!/usr/bin/with-contenv bashio


fun() {  while true; do nc -l -p 8099 -e  echo -e 'HTTP/1.1 200 OK\r\nServer: EnableSerial\r\nDate:$(date)\r\nContent-Type: text/html; charset=UTF8\r\nCache-Control: no-store, no cache, must-revalidate\r\n\r\n<!DOCTYPE html><html><body><p>Serial Ingress! It is here, and there is nothing left to say.</body></html>\r\n\n\n'; done }; fun&

config='dtoverlay=dwc2,dr_mode=host'
until false; do
set +e
  mkdir /tmp 2>/dev/null
  mkdir /tmp/mmcblk0p1 /tmp/sda1 2> /dev/null
  if [ ! -e /dev/sda1 ] && [ ! -e /dev/sdb1 ] && [ ! -e /dev/mmcblk0p1 ]; then 
    echo "nothing to do. Is protection mode enabled?  You can't run this without disabling protection mode";
    while true; do sleep 99999; done;

  fi;


  performWork () {
    partition=$1
    mount /dev/$partition /tmp/$partition 2>/dev/null
    if [ -e /tmp/$partition/config.txt ]; then
      if [ $(grep "$config" /tmp/$partition/config.txt|grep -v \#) ]; then
        echo "serial already configured on $partition";
      else
        echo "adding $config to $partition config.txt"
        echo "$config">>/tmp/$partition/config.txt
      fi
    else
      echo "no $partition config found"
    fi
  }

  performWork sda1
  performWork sdb1
  performWork mmcblk0p1

  echo "This Configurator did it's job. Perform a hard-power-off now. You can uninstall and reboot now.  This configurator only works once."
  sleep 99999;
done

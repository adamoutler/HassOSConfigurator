#!/usr/bin/with-contenv bashio


key=$(cat options.json |jq -r '.SSHKey')
until false; do
set +e
  mkdir /tmp 2>/dev/null
  mkdir /tmp/mmcblk0p1 /tmp/sda1 2> /dev/null
  if [ ! -e /dev/sda ] && [ ! -e /dev/mmcblk0p1 ]; then 
    echo "nothing to do. Is protection mode enabled?  You can't run this without disabling protection mode";
    exit;
  fi;


  performWork () {
    partition=$1
    mount /dev/$partition /tmp/$partition 2>/dev/null
    if [ grep "$key" /tmp/$partition/config.txt ]; then
      echo "already added this key to $partition";
      return;
    fi;
    if [ -e /tmp/$partition/config.txt ]; then
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

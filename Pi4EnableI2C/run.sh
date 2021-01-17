#!/usr/bin/with-contenv bashio
whoami
id

config='dtparam=i2c_vc=on'
config2='dtparam=i2c_arm=on'
until false; do
set +e
  mkdir /tmp 2>/dev/null

  ls -al /dev/ 2>1
  mkdir /tmp/mmcblk0p1 /tmp/sda1 2> /dev/null
  if [ ! -e /dev/sda1 ] && [ ! -e /dev/sdb1 ] && [ ! -e /dev/mmcblk0p1 ]; then 
    echo "nothing to do. Is protection mode enabled?  You can't run this without disabling protection mode";
    exit
  fi;


  performWork () {
    partition=$1
    if [ ! -e /dev/$partition ]; then
       echo "no $partition available"
       return;
    fi
    umount /tmp/$partition 2>/dev/null
    mount /dev/$partition /tmp/$partition 
    if [ -e /tmp/$partition/config.txt ]; then
      mkdir -p /tmp/$partition/CONFIG/modules
      echo i2c-dev >/tmp/$partition/CONFIG/modules/rpi-i2c.conf
      if [ $(grep "$config" /tmp/$partition/config.txt|grep -v \#) ]; then
        echo "i2c already configured on $partition";
      else
        echo "adding $config to $partition config.txt"
        echo "$config">>/tmp/$partition/config.txt
      fi
      if [ $(grep "$config2" /tmp/$partition/config.txt|grep -v \#) ]; then
        echo "i2c already configured on $partition";
      else
        echo "adding $config2 to $partition config.txt"
        echo "$config2">>/tmp/$partition/config.txt
      fi
    else
      echo "no $partition config found"
    fi
  }
  if [ $(ls /dev/i2c-1) ]; then 
    echo $(ls /dev/)
    echo "Found i2c access!  Nothing to do!  You can remove this add-on.";
  else 
    echo "I don't see I2C."
    performWork sda1
    performWork sdb1
    performWork mmcblk0p1
    echo "This Configurator did it's job. Perform a hard-power-off reboot now."
    echo "You will need to reboot twice total, once to place the files, and again to activate the I2C."
  fi
  
  sleep 99999;
done

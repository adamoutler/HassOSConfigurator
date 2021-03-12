#! /usr/bin/with-contenv bash
whoami
id

echo $0

nc -lk -p 8099 -e  echo -e 'HTTP/1.1 200 OK\r\nServer: DeskPiPro\r\nDate:$(date)\r\nContent-Type: text/html; charset=UTF8\r\nCache-Control: no-store, no cache, must-revalidate\r\n\r\n<!DOCTYPE html><html><body><p>HassOS I2C Configurator WebUI.  This is it. Impressive, right?</p></body></html>\r\n\n\n' & 

config='dtparam=i2c_vc=on'
config2='dtparam=i2c_arm=on'
until false; do
  set +e
  mkdir /tmp 2>/dev/null

  ls -al /dev/ 2>&1
  mkdir /tmp/mmcblk0p1 /tmp/sda1 2> /dev/null
  if [ ! -e /dev/sda1 ] && [ ! -e /dev/sdb1 ] && [ ! -e /dev/mmcblk0p1 ]; then 
    echo "nothing to do. Is protection mode enabled?  You can't run this without disabling protection mode";
    while true; do sleep 99999; done;
  fi;


  performWork () {
    partition=$1
    if [ ! -e /dev/$partition ]; then
      echo "no $partition available"
      return;
    fi
    umount /tmp/$partition 2>/dev/null
    result=$(mount /dev/$partition /tmp/$partition 2>&1);
    echo $result
    [[ "$result" == *"root"* ]] && echo "Detected Protection Mode is enabled. Disable Protection Mode in Info Screen."
    if [ -e /tmp/$partition/config.txt ]; then
      mkdir -p /tmp/$partition/CONFIG/modules;
      echo i2c-dev >/tmp/$partition/CONFIG/modules/rpi-i2c.conf;

      #debian support for i2c-bcm2708
      if  ls /tmp/$partition | grep vmlinuz; then
        echo "Detected raspian, not HASSOS"
        p2=${partition::-1}2;
        mkdir -p /tmp/${p2}
        mount /dev/${p2} /tmp/${p2}
        if ! grep bcm /tmp/${p2}/etc/modules; then
          echo -e "i2c-bcm2708">>/tmp/${p2}/etc/modules;
        fi
        if ! grep i2c-dev /tmp/${p2}/etc/modules; then
          echo -e "i2c-dev">>/tmp/${p2}/etc/modules
        fi
      fi
      if grep "$config" /tmp/$partition/config.txt|grep -v \#; then
        echo "i2c already configured on $partition. Reboot required.";
      else
        echo "adding $config to $partition config.txt"
        echo "$config">>/tmp/$partition/config.txt
      fi
      if grep "$config2" /tmp/$partition/config.txt|grep -v \#; then
        echo "i2c already configured on $partition. This addon was already run during this boot and no reboot occurred. ";
      else
        echo "adding $config2 to $partition config.txt"
        echo "$config2">>/tmp/$partition/config.txt
      fi
    else
      echo "no $partition config found"
    fi
  }
  if ls /dev/i2c-1; then 
    echo $(ls /dev/*i2c*)
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

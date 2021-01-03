![image](gitResources/activecooling.jpg)

This is an addon for DeskPi Pro in Home Assistant.  It's essentially a script that runs in a docker container.  It enables and automates the DeskPi Pro Active Cooling System with your specifications.<br>

# Installation
Within Home Assistant, click Supervisor-> Add-on Store -> … button (in top left)-> Repositories. Add this repository. 

Click DeskPi Pro Temp Control and install.<br>
![image](gitResources/addonSelect.png)

# Configuration
![image](gitResources/Configuration.png)
## Celcius or Farenheit
Choose Celcius or Farenheit.
* **CorF** - Configures Celcius or Fahrenheit.

## Temperature Ranges
![image](gitResources/FanRangeExplaination.png)

Set your fan ranges appropriately. 
* **LowRange** Minimum Temperature to turn on 33%. Temperatures less than this value will turn the fan off.
* **MediumRange** to be the temperature divider between 33 and 66%.
* **HighRange** to be the maximum temperature before 100% fan.


# Enable Serial
In order to enable Serial, you must add ```dtoverlay=dwc2,dr_mode=host``` to your config.txt.  You can do this from a computer, a terminal addon, or from the hassio main terminal.

## Edit config.txt method 
plug your sdcard or memory stick into a computer and modify the config.txt file.
```
dtoverlay=dwc2,dr_mode=host
```

## Terminal Addon method
If you have a terminal addon, you can disable protection mode and execute the following. 

### Built-in hard drive
```mount /dev/sda1 /mnt
echo 'dtoverlay=dwc2,dr_mode=host' >> /mnt/config.txt
```
### SDCard
```mount /dev/mmcblk0p1 /mnt
echo 'dtoverlay=dwc2,dr_mode=host' >> /mnt/config.txt
```

## Hassio Main Terminal
Login to the main terminal, then at the ha> prompt, type "login". 
```
echo 'dtoverlay=dwc2,dr_mode=host' >> /mnt/boot/config.txt
```
# HassOSConfigurator

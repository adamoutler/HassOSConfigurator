# Addon Repository
This an addon repository for HassOS Configurator projects.  These projects perform configuration tasks.<br>

All projects require a reboot and may be uninstalled after the first successful run.  Please observe logs to determine if the run was successful. 

## [HassOS I2C Configurator](https://github.com/adamoutler/HassOSConfigurator/tree/main/Pi4EnableI2C)
Enables the Raspberry Pi I<sup>2</sup>C bus Bus.  For support, click [here](https://community.home-assistant.io/t/hassos-i2c-configurator/264167).

## [HassOS Serial Configurator](https://github.com/adamoutler/HassOSConfigurator/tree/main/Pi4EnableSerial)
Enables the Raspberry Pi 4 Serial Port. Instead of Device Mode, the port becomes Host Mode for utilization by the Operating System. For support click [here](https://community.home-assistant.io/t/hassos-serial-configurator/264169)

## [HassOS SSH port 22222 Configurator](https://github.com/adamoutler/HassOSConfigurator/tree/main/HassOsEnableSSH)
Places an authorized_keys file in the location required by HassOS at boot time to enable the SSH port 22222. For support click [here](https://community.home-assistant.io/t/hassos-ssh-port-22222-configurator/264109)

# Installation
Within Home Assistant, click Supervisor-> Add-on Store -> … button (in top left)-> Repositories. Add this repository. 

Click one of the items and install.<br>
![image](gitResources/repository.jpg)


# Operation

**Important Note** when requested to reboot, choose Supervisor->Reboot Host or pull the power plug from your machine and restart it. 
Hit the start button and observe the logs.  You may uninstall the Add-On when complete. 

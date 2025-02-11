## Normal Operation
The purpose of this add-on is to perform tasks on startup for each container, within the context of that container.  Tasks such as mounting folders, pinging REST APIs, starting servers, and other such tasks may be performed by scripts.  

**Warning**- Your scripts will run as root and have the capability of destroying your machine. 

## Scripts
Scripts for each container may be placed in the home assistant configuration folder, usually /config/startup/startup.d/name-of-container.sh. 

## Logs
Logs may be found in the home assistant configuration folder, usually /config/startup/logs/name-of-container.log

## Options
| Setting name | Valid Values| Description |
|---|---|---|
|Seconds to wait before startup scripts execute| 1-999999 |Provides a delay from the time this container starts until the time it will begin executing commands in other containers. 
|Create example scripts in /config/startup/startup.d"|lowercase true/false|If true, a script for all running containers will be created in the /config/startup/startup.d folder. Each created script will display the environmental variables for the container.|
|Retain old logs in /config/startup/logs/ instead of deleting old logs|lowercase true/false| If true, logs will be appended. Otherwise, logs will be replaced on each startup. |

## Support
Support is provided on the [Home Assistant Community forums](https://community.home-assistant.io/t/run-on-startup-d/271008).  Git Issues may be ignored.

If problems are encountered please get all "Karen" in the forums and make sure to display attitude, because developers love that.  Alternatively, you can provide a log and tell us the problem, what you did, the model of your device, and what happened differently than what you expected.


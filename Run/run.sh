#!/usr/bin/with-contenv bashio

PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

#Test docker access
echo "Testing Docker access.";
set +e

## Test for docker access
docker container ls 2>&1>/dev/null;
if [ $? != 0 ]; then
 echo "You must disable protection mode. sleeping..."
 while true; do sleep 9999; done;
fi

#Sleep for delay period
delay=$(cat options.json |jq -r '."Seconds to wait before startup scripts execute"')
createScripts=$(cat options.json |jq -r '."Create example scripts in /config/startup/startup.d"')
test $(cat options.json |jq -r '."Retain old logs in /config/startup/logs/ instead of deleting old logs"') == "true" && logOption="-a"
echo "Sleeping for Startup Delay period of $delay seconds"
sleep $delay;

#Log server
nc -lk -p 8099 -e  exec /opt/logcontent.sh 3>/dev/null &

#Get containers
echo "Listing Containers."
containers=$(docker ps --format "{{.Names}}")
for container in $containers; do 
  echo $container;
  if [ $createScripts == "true" ]; then 
    test ! -e /config/startup/startup.d/$container.sh && echo -e "#! /bin/bash\n\necho \"This script is executed in the $container container\"; \nenv;">/config/startup/startup.d/$container.sh
  fi
done;

#Start running
echo "executing";
mkdir -p /config/startup/startup.d
mkdir -p /config/startup/logs

#Set the environment to continue executing and start running all the scripts
for container in $containers; do
  containerid=$(docker ps -aqf "name=$container")
  if [ ! -e /config/startup/startup.d/$container.sh ]; then
    continue;
  fi
  echo "#############################################################################";
  echo "###############/config/startup/startup.d/$container.sh";
  echo "###############Container: $containerid: tmp/$container.startup.sh";
  echo "#############################################################################"
  docker cp /config/startup/startup.d/$container.sh $containerid:/tmp/$container.startup.sh;
  docker exec -t $containerid chmod 755 /tmp/$container.startup.sh;
  docker exec -t $containerid exec /tmp/$container.startup.sh 2>&1 | tee $logOption /config/startup/logs/$container.log &
  sleep 1;
done;
set -e
echo;echo;echo;echo;
echo "----DONE----  sleeping...";
sleep 99999;

#!/usr/bin/with-contenv bashio

PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin


command=$(cat options.json |jq -r '.command');
container=$(cat options.json |jq -r '.container');

echo "executing";
set +e
echo " Switching to Home Assistant environment and execting script at \"/config/startup/runme.sh\""
mkdir -p /config/startup

#test ! docker container ls 2>&1 >/dev/null && echo "you must disable protection mode" && exit
test ! -e /config/startup/runme.sh && echo "echo this is the example script \nenv\nls /\n echo you can find the example in /config/startup/runme.sh and modify it for your own purposes">/config/startup/runme.sh
docker exec -t $(docker container ls|grep "$container"|awk '{print $1}') bash /config/startup/runme.sh
set -e
echo;echo;echo;echo;
echo "----DONE----  sleeping...";
sleep 99999;

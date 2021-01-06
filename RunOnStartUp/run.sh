#!/usr/bin/with-contenv bashio

PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

command=$(cat options.json |jq -r '.command');
echo "executing";
$command;

echo;echo;echo;echo;
echo "----DONE----  sleeping...";
sleep 99999;

#!/bin/bash

PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

command=$(cat options.json |jq -r '.command');
container=$(cat options.json |jq -r '.container');
echo "executing";
docker exec  $(docker container ls|grep "$container"|awk '{print $1}') \'$command\';

echo;echo;echo;echo;
echo "----DONE----  sleeping...";
sleep 99999;

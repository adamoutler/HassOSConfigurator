#! /bin/bash
containersvar=$(docker ps --format "{{.Names}}")
containerscs=$(echo $containersvar|sed 's/\ /,/g')

IFS=',' read -r -a containers <<<"$containerscs"


echo -e 'HTTP/1.1 200 OK\r\nServer: DeskPiPro\r\nDate:$(date)\r\nContent-Type: text/html; charset=UTF8\r\nCache-Control: no-store, no cache, must-revalidate\r\n\r\n'

echo -e \
"<!DOCTYPE html>\n"\
"<html>\n"\
"<head>\n"\
"<title>Page Title</title>\n"\
"</head>\n"\
"<body>\n"\

for i in "${containers[@]}"; do
  echo -e "<H2>$i</H2>"
  file="/config/startup/logs/"$i".log";
  test -e ${file} && cat ${file}|sed 's/$/<br>/g'

done

echo -e \
"</body>\n"\
"</html>\n"\
"\n"

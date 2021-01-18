ARG BUILD_FROM
FROM $BUILD_FROM
ENV LANG C.UTF-8
COPY run.sh /
WORKDIR /data
RUN chmod a+x /run.sh
RUN apk add docker --no-cache

CMD [ "pwd" ]
CMD [ "id" ]
CMD [ "env" ]
cmd [ "ls", "/bin"]
CMD [ "/run.sh" ]

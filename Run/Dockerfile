ARG BUILD_FROM
FROM $BUILD_FROM
ENV LANG C.UTF-8
COPY run.sh /
WORKDIR /data
RUN chmod a+x /run.sh
RUN apk add docker --no-cache
COPY rootfs /
CMD [ "/run.sh" ]

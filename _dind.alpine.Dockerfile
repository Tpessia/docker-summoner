# Alpine Based
FROM alpine:3.11.5

RUN apk update
RUN apk add docker --no-cache
RUN apk add openrc --no-cache

# StartUp Init
# RUN rc-update add docker boot

# Init
RUN service docker start

# ENTRYPOINT dockerd & sh
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/bin/sh"]
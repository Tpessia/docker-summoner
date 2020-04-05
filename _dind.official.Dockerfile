# Alpine Based
FROM docker:19.03.8-dind

ENV DOCKER_TLS_CERTDIR=/certs

# ENTRYPOINT dockerd & sh
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/bin/sh"]
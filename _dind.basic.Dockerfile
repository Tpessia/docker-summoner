# Alpine Based
FROM docker:19.03.8

RUN apk add openrc --no-cache
RUN apk add shadow --no-cache

# CMD ["service","docker","start"]
# addgroup docker
# addgroup $(whoami) docker
# newgrp docker
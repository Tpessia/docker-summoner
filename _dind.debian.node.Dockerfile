# Debian (Stretch) Based
FROM node:12.16.1-stretch-slim

RUN apt-get update

# Install packages to allow apt to use a repository over HTTPS
RUN apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Add Docker’s official GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

# Verify that you now have the key with the fingerprint
# RUN apt-key fingerprint 0EBFCD88

# Set up the stable repository
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

RUN apt-get update

# Install the latest version of Docker Engine
RUN apt-get -y install docker-ce docker-ce-cli containerd.io

# ENTRYPOINT dockerd & sh
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/bin/sh"]
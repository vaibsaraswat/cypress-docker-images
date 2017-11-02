FROM ubuntu:16.04

RUN apt-get update && \
  apt-get install -y apt-transport-https curl

RUN touch /etc/apt/sources.list.d/nodesource.list
RUN echo "deb https://deb.nodesource.com/node_6.x xenial main" > /etc/apt/sources.list.d/nodesource.list
RUN echo "deb-src https://deb.nodesource.com/node_6.x xenial main" >> /etc/apt/sources.list.d/nodesource.list

RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
RUN apt-get update

# Should install Node 6
RUN apt-get install -y nodejs

# Install Cypress dependencies
RUN apt-get install -y \
    libgtk2.0-0 \
    libnotify-dev \
    libgconf-2-4 \
    libnss3 \
    libxss1 \
    libasound2 \
    xvfb

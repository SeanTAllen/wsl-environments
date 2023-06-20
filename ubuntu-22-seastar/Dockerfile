FROM ubuntu:22.04

WORKDIR /tmp

# The Ubuntu 22.04 docker images exludes docs and man pages on install.
# I want them. Now get back what we lost
COPY unminimize /tmp/unminimize
RUN /tmp/unminimize

# allow user name 'sean' to run hwclock -s without password
COPY sean_hwclock /etc/sudoers.d/

# set wsl configuration
COPY wsl.conf /etc/wsl.conf

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
 && apt-get install -y \
  apt-transport-https \
  build-essential \
  clang \
  cmake \
  curl \
  fish \
  git \
  gpg \
  htop \
  lldb \
  locales-all \
  make \
  man \
  manpages-posix\
  ninja-build \
  shellcheck \
  software-properties-common \
  sudo \
  vim \
  wget \
  yadm

# Starship
RUN wget https://starship.rs/install.sh \
 && sh install.sh -y

RUN groupadd sean \
 && useradd -ms /usr/bin/fish -d /home/sean -G adm,sudo -g sean sean \
 && echo "sean:password" | chpasswd

USER sean

RUN mkdir -p ~/code/seantallen \
 && mkdir -p ~/bin \
 && mkdir -p ~/tmp \
 && mkdir ~/.ssh \
 && chmod 700 ~/.ssh

WORKDIR /home/sean

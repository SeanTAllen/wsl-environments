FROM ubuntu:22.04

WORKDIR /tmp

# The Ubuntu 22.04 docker images exludes docs and man pages on install.
# I want them. Now get back what we lost
COPY unminimize /tmp/unminimize
RUN /tmp/unminimize

# docker.io doesn't setup so that `service docker start` will work.
# Fix that
COPY docker /etc/init.d/docker

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
  docker.io \
  fish \
  git \
  gpg \
  htop \
  libpcre2-dev \
  libssl-dev \
  lldb \
  locales-all \
  make \
  man \
  manpages-posix\
  shellcheck \
  software-properties-common \
  sudo \
  tree \
  vim \
  wget \
  yadm

# Starship
RUN wget https://starship.rs/install.sh \
 && sh install.sh -y

RUN groupadd sean \
 && useradd -ms /usr/bin/fish -d /home/sean -G adm,docker,sudo -g sean sean \
 && echo "sean:password" | chpasswd

USER sean

RUN mkdir -p ~/code/ponylang \
 && mkdir -p ~/code/seantallen \
 && mkdir -p ~/code/seantallen-org \
 && mkdir -p ~/bin \
 && mkdir -p ~/pony-scratch \
 && mkdir -p ~/tmp \
 && mkdir ~/.ssh \
 && chmod 700 ~/.ssh

WORKDIR /home/sean/tmp

# Hugo 56.3 extended
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.56.3/hugo_extended_0.56.3_Linux-64bit.tar.gz \
 && tar xzf hugo_extended_0.56.3_Linux-64bit.tar.gz \
 && mv hugo ~/bin/hugo-extended-56 \
 && chmod a+x ~/bin/hugo-extended-56 \
 && ln -s ~/bin/hugo-extended-56 ~/bin/hugo

# Hugo for ponylang.io
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.24.1/hugo_0.24.1_Linux-64bit.tar.gz \
 && tar xzf hugo_0.24.1_Linux-64bit.tar.gz \
 && mv hugo ~/bin/hugo-24.1 \
 && chmod a+x ~/bin/hugo-24.1

# ponyup
ENV PATH "/home/sean/.local/share/ponyup/bin:$PATH"
RUN curl -s --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/ponylang/ponyup/master/ponyup-init.sh | bash \
 && ponyup default x86_64-linux-ubuntu20.04 \
 && ponyup update ponyc release \
 && ponyup update corral release \
 && ponyup update changelog-tool release

# vim numbers plugin
RUN git clone https://github.com/b3niup/numbers.vim.git ~/.vim/pack/numbers/start/numbers

# vim pony syntax highlighting plugin
RUN git clone https://github.com/dleonard0/pony-vim-syntax.git ~/.vim/pack/pony-vim-syntax/start/pony-vim-syntax

WORKDIR /home/sean

RUN rm -rf /home/sean/tmp/*

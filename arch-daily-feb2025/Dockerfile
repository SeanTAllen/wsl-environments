FROM archlinux:base

LABEL org.opencontainers.image.source="https://github.com/seantallen/wsl-environments"

COPY nsswitch.conf /etc/nsswitch.conf
COPY pacman.conf /etc/pacman.conf
COPY wsl.conf /etc/wsl.conf

# Remove dead community repo from pacman if it is still there in the image
RUN sed -i '/^\[community\]/,/^$/d' /etc/pacman.conf

# We need to have docker set as group 107 for docker in docker with
# my dev-enviroments to work
RUN groupadd -g 107 docker

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
 && locale-gen

RUN pacman -Syyu --noconfirm \
 && pacman -S --noconfirm \
  man \
  man-pages \
  7zip \
  atuin \
  clang \
  cmake \
  curl \
  dnsutils \
  docker \
  docker-buildx \
  fd \
  fish \
  fisher \
  fzf \
  git \
  gnupg \
  helix \
  htop \
  jq \
  lldb \
  lsof \
  make \
  openssh \
  openssl \
  pcre2 \
  ripgrep \
  shellcheck \
  starship \
  sudo \
  systemd \
  vim \
  wget \
  which \
  yadm \
  yazi \
  zoxide

RUN groupadd sean \
 && useradd -ms /usr/bin/fish -d /home/sean -G adm,docker,wheel -g sean sean \
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

# vim numbers plugin
RUN git clone https://github.com/b3niup/numbers.vim.git ~/.vim/pack/numbers/start/numbers

# vim pony syntax highlighting plugin
RUN git clone https://github.com/dleonard0/pony-vim-syntax.git ~/.vim/pack/pony-vim-syntax/start/pony-vim-syntax

# scooter find/replace
RUN wget https://github.com/thomasschafer/scooter/releases/download/v0.8.4/scooter-v0.8.4-x86_64-unknown-linux-musl.tar.gz \
  && tar xf scooter* \
  && mv scooter /home/sean/bin/

WORKDIR /home/sean

RUN rm -rf /home/sean/tmp/*

RUN yadm clone https://github.com/SeanTAllen/yadm-dotfiles.git \
 && yadm checkout /home/sean \
 && fish -c "fisher install jethrokuan/z"

RUN ln -s /usr/sbin/pinentry-tty ~/bin/pinentry-tty

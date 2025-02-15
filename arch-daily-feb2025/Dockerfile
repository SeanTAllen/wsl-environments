FROM archlinux:base

LABEL org.opencontainers.image.source="https://github.com/seantallen/wsl-environments"

COPY wsl.conf /etc/wsl.conf

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
 && locale-gen

RUN pacman -Syyu --noconfirm \
 && pacman -S --noconfirm \
  man \
  man-pages \
  atuin \
  clang \
  cmake \
  curl \
  docker \
  fish \
  fisher \
  git \
  gnupg \
  htop \
  lldb \
  make \
  openssh \
  openssl \
  pcre2 \
  shellcheck \
  starship \
  sudo \
  vim \
  wget \
  yadm

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

WORKDIR /home/sean

RUN rm -rf /home/sean/tmp/*

RUN yadm clone https://github.com/SeanTAllen/yadm-dotfiles.git \
 && yadm checkout /home/sean \
 && fish -c "fisher install jethrokuan/z"

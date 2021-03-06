FROM seebaktec/zsh

ARG VERSION=0.0.0
   
LABEL "Version" = $VERSION
LABEL "Name" = "devtools-tmux"

USER root

# Install tmux
RUN apt-get update \ 
    && apt-get install -y -q --allow-unauthenticated \
    tmux \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/* 

USER admin

WORKDIR /home/admin

# Configuring Oh-my-tmux
RUN git clone https://github.com/gpakosz/.tmux.git \
    && ln -s -f .tmux/.tmux.conf \
    && cp .tmux/.tmux.conf.local . \
    && sed -i '/tmux_conf_copy_to_os_clipboard/s/false/true/g' /home/admin/.tmux.conf.local \
    && sed -i '/tmux_conf_theme_mouse/s/↗/🕹️/g' /home/admin/.tmux.conf.local \
    && sed -i '/tmux_conf_theme_mouse/s/2197/1F579/g' /home/admin/.tmux.conf.local

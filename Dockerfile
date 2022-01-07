FROM alpine:3.15

LABEL author="Davor Sauer"

RUN apk update \
    && apk add bash bind-tools curl \
                iproute2 iputils jq mtr httpie git zsh vim npm \
                net-tools nginx openssl \
                perl-net-telnet procps tcpdump tcptraceroute wget \
    && curl -sL https://raw.githubusercontent.com/variantdev/get/master/get | INSTALL_TO=/usr/bin sh \
    && mkdir /certs /docker \
    && chmod 700 /certs \
    && openssl req \
        -x509 -newkey rsa:2048 -nodes -days 3650 \
        -keyout /certs/server.key -out /certs/server.crt -subj '/CN=localhost' \
    && echo 'root:toorpass' | chpasswd

################################
# nginx
################################
EXPOSE 80 443 1180 11443
COPY config/nginx/nginx.conf /etc/nginx/nginx.conf
COPY services/index.html /usr/share/nginx/html/
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]


################################
# Setup dev user
################################
# Add a new user "dev" with user id 9377
RUN addgroup -S dev \
    && adduser \
      --disabled-password \
      -s zsh -g developer -u 9377 -G dev -S dev



################################
# api-tools
################################
COPY template /opt/template
COPY tooling /opt/tooling

# Setup API cli
RUN chmod +x /opt/tooling/api/api.yaml \
    && ln -s /opt/tooling/api/api.yaml /usr/bin/api

# Add autocomplete
## TODO: autocomplete for api clis for zsh

################################
# Workdir
################################
RUN mkdir /opt/workspace
WORKDIR /opt/workspace
VOLUME ["/opt/workspace"]

# Change to non-root user
# Install zsh for the user
USER dev
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
#    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
COPY config/user/ /home/dev/


COPY entrypoint.sh /opt
ENTRYPOINT ["/opt/entrypoint.sh"]
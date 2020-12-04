# The PHP_EXTENSIONS ARG will apply to the "slim" image
ARG PHP_EXTENSIONS="apcu bcmath gd mysqli opcache pdo_mysql soap zip"
ARG PHP_VERSION=7.4

FROM thecodingmachine/php:$PHP_VERSION-v3-apache-node12

ENV APACHE_DOCUMENT_ROOT=/var/www/html

USER root

RUN apt-get update \
 && apt-get install -y g++ gcc keychain make mysql-client python rsync wget --no-install-recommends

COPY apache2/sites-available/* /etc/apache2/sites-available/
RUN a2ensite web.conf \
 && a2ensite production.conf \
 && a2ensite pre-production.conf \
 && a2ensite post-production.conf

RUN composer self-update --2

USER docker

WORKDIR /home/docker

ADD --chown=docker:docker package.json ./package.json
ADD --chown=docker:docker .wakatime.cfg ./.wakatime.cfg
ADD --chown=docker:docker plugins /home/docker/plugins

ARG GITHUB_TOKEN

ENV HOME=/home/docker \
    THEIA_DEFAULT_PLUGINS=local-dir:/home/docker/plugins \
    SHELL=/bin/bash \
    USE_LOCAL_GIT=true \
    PHP_EXTENSION_XDEBUG=1 \
    XDEBUG_CONFIG="idekey=theia remote_connect_back=0 remote_host=localhost" \
    PHP_EXTENSION_BLACKFIRE=1 \
    PHP_EXTENSION_GD=1 \
    PHP_INI_ERROR_REPORTING=E_ALL \
    PHP_INI_MEMORY_LIMIT=2g

RUN yarn --pure-lockfile && \
    NODE_OPTIONS="--max_old_space_size=4096" yarn theia build && \
    yarn theia download:plugins && \
    yarn --production && \
    yarn autoclean --init && \
    echo *.ts >> .yarnclean && \
    echo *.ts.map >> .yarnclean && \
    echo *.spec.* >> .yarnclean && \
    yarn autoclean --force && \
    yarn cache clean && \
    wget https://raw.githubusercontent.com/theia-ide/theia-apps/master/theia-electron/resources/icon.ico -P ./lib/ && sed -i 's/<meta charset/<link rel="icon" href=".\/icon.ico" type="image\/x-icon">\n  <meta charset=/' ./lib/index.html

COPY --chown=docker:docker ./settings.json /home/docker/.theia/settings.json

RUN echo '\n/usr/bin/keychain --quiet ~/.ssh/id_rsa\n.  ~/.keychain/$HOSTNAME-sh\n' >> ~/.bashrc

EXPOSE 3000

ENV STARTUP_COMMAND_THEIA_1='[ -z "$GIT_USER_NAME" ] || git config --global user.name "$GIT_USER_NAME"'
ENV STARTUP_COMMAND_THEIA_2='[ -z "$GIT_USER_EMAIL" ] || git config --global user.email "$GIT_USER_EMAIL"'
ENV STARTUP_COMMAND_THEIA_3='sed -i "s/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX/$WAKATIME_API_KEY/g"  /home/docker/.wakatime.cfg'
ENV STARTUP_COMMAND_THEIA_4="node /home/docker/src-gen/backend/main.js \$PWD --app-project-path=/home/docker --hostname=0.0.0.0 &"

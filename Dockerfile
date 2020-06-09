# The PHP_EXTENSIONS ARG will apply to the "slim" image
ARG PHP_EXTENSIONS="apcu mysqli opcache pdo_mysql zip soap"

FROM thecodingmachine/php:7.4-v3-apache-node10

ENV APACHE_DOCUMENT_ROOT=/var/www/html

USER root

RUN apt-get update && \
    apt-get install -y make gcc g++ python --no-install-recommends

USER docker

WORKDIR /home/docker

ADD latest.package.json ./package.json

ARG GITHUB_TOKEN

RUN yarn --pure-lockfile && \
    NODE_OPTIONS="--max_old_space_size=4096" yarn theia build && \
    yarn theia download:plugins && \
    yarn --production && \
    yarn autoclean --init && \
    echo *.ts >> .yarnclean && \
    echo *.ts.map >> .yarnclean && \
    echo *.spec.* >> .yarnclean && \
    yarn autoclean --force && \
    yarn cache clean

ENV HOME=/home/docker \
    THEIA_DEFAULT_PLUGINS=local-dir:/home/docker/plugins \
    SHELL=/bin/bash \
    USE_LOCAL_GIT=true \
    PHP_EXTENSION_XDEBUG=1 \
    XDEBUG_CONFIG="idekey=cloud9ide remote_connect_back=0 remote_host=localhost" \
    PHP_EXTENSION_BLACKFIRE=1 \
    PHP_EXTENSION_GD=1 \
    PHP_INI_ERROR_REPORTING=E_ALL \
    PHP_INI_MEMORY_LIMIT=2g

RUN mkdir -p .theia/plugins && \
    mkdir -p .theia/extensions

COPY --chown=docker:docker ./settings.json /home/docker/.theia/settings.json

EXPOSE 3000

ENV STARTUP_COMMAND_THEIA_1="node /home/docker/src-gen/backend/main.js \$PWD --app-project-path=/home/docker --hostname=0.0.0.0 &"
#ENV STARTUP_COMMAND_THEIA_1="yarn start \$PWD --hostname 0.0.0.0 --port 3000 --root-dir /home/theia &"

# Docker Theia PHP

A Docker image based on [thecodingmachine/docker-images-php](https://github.com/thecodingmachine/docker-images-php#general-purpose-php-images-for-docker)
with addition of the browser based IDE [Theia](https://theia-ide.org/) set up
for coding PHP. **This is not an official docker image!** Subject to change as
it is used for personal development purposes.

## Usage:

Setup a docker-compose.yml file and run `docker-compose up -d`:

```
version: '3'
services:
  web:
    image: verbral/docker-theia-php
    working_dir: ${PWD}
    ports:
      - 80:80
      - 3000:3000
    environment:
      APACHE_DOCUMENT_ROOT: ${PWD}
      # Set your Git user and name for commit purposes.
      GIT_USER_NAME:
      GIT_USER_EMAIL:
      # Set your Github API token for Composer usage.
      GITHUB_API_TOKEN:
      # Set your Wakatime API key if you use the plugin.
      WAKATIME_API_KEY:
    volumes:
      # Mount path as is for xdebug.
      - ${PWD}:${PWD}
      # Mount a folder with additional plugins for theia.
      - ./plugins:/plugins
      # Mount your SSH folder for git purposes.
      - ~/.ssh:/home/docker/.ssh
```
After this your application will be available on port 80 and your IDE will be
available on port 3000.

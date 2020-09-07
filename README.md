![example workflow name](https://github.com/actions/verbruggenalex/docker-theia-php/.github/workflows/docker-image.yml/badge.svg)
![GitHub last commit](https://img.shields.io/github/last-commit/verbruggenalex/docker-theia-php)
![Docker Image Size](https://img.shields.io/docker/image-size/verbral/docker-theia-php)
![Docker Pulls](https://img.shields.io/docker/pulls/verbral/docker-theia-php)

# Docker Theia PHP

![Theia](/theia-screenshot.png)

## About

A Docker image based on [thecodingmachine/docker-images-php](https://github.com/thecodingmachine/docker-images-php#general-purpose-php-images-for-docker)
with addition of the browser based IDE [Theia](https://theia-ide.org/) set up
for coding PHP. **This is not an official docker image!** Subject to change as
it is used for personal development purposes.

## Versions

| Image name | Image size |
| ---------- | ---------- |
| verbral/docker-theia-php:7.2 | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/verbral/docker-theia-php/7.2) |
| verbral/docker-theia-php:7.3 | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/verbral/docker-theia-php/7.3) |
| verbral/docker-theia-php:7.4 | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/verbral/docker-theia-php/7.4) |

## Usage:

<details>
 <summary>Setup a docker-compose.yml file with the following contents:</summary>

```yaml
version: '3'
services:
  web:
    image: verbral/docker-theia-php:7.4
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
      # Mount your SSH folder for git purposes.
      - ~/.ssh:/home/docker/.ssh
```
</details>

```
docker-compose up -d
```

After this your application will be available on port 80 and your IDE will be
available on port 3000.

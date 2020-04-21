# Contents

- ubuntu:18.04
- apache
- php:7.4
- composer

## Requirements

- docker: https://docs.docker.com/engine/install/ubuntu/
- docker-compose: https://docs.docker.com/compose/install/

## Usage

### First way (Terminal)

Open terminal and run command:
`docker run --name php-laravel -d -p 80:80 -t ocnascimento/php7.4-laravel:1.0`

### Second way (Docker-compose)

Create file `docker-compose.yaml`:

```yaml
version: "3"
services:
  app:
    build: .
    ports:
      - 80:80
```

Create file `Dockerfile`:

```Dockerfile
FROM ocnascimento/php7.4-laravel:1.0
```

## License

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

- **[MIT license](https://mit-license.org/)**
- Copyright 2020 © <a href="javascript:;" target="_blank">OCN</a>.

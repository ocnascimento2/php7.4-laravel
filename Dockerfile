FROM ubuntu:18.04

LABEL maintainer 'Orlando Nascimento <ocnasicmento2@gmail.com>'

WORKDIR /var/www/public

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -yq --no-install-recommends \
  # TOOLS
  nano \
  curl \
  git \
  unzip \
  # APACHE
  apache2 \
  # PHP
  software-properties-common \
  && add-apt-repository -y ppa:ondrej/php \
  && apt-get install -y php7.4 \
  && apt-get install -y wget php-cli php-mbstring php-xml php-zip \
  # COMPOSER 
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && HASH="$(wget -q -O - https://composer.github.io/installer.sig)"\
  && php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
  # LARAVEL
  && composer global require laravel/installer \
  # CLEAR 
  && apt-get clean


RUN a2enmod rewrite \
  && sed -i 's/html/public/' /etc/apache2/sites-available/000-default.conf \
  && sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

RUN chmod -R 775 /var/www/public

RUN touch index.php \
  && echo "<?php phpinfo();" >> index.php

COPY . /var/www/public

CMD apachectl -D FOREGROUND
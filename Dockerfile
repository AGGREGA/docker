FROM ubuntu:20.04

WORKDIR /var/www/
LABEL maintainer="Aggrega"
ENV DEBIAN_FRONTEND noninteractive
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
    && apt-get install -y software-properties-common zip unzip curl nginx supervisor git ssh tzdata unoconv \
    && add-apt-repository ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y php8.0-cli php8.0-dev \
       php8.0-pgsql php8.0-tokenizer php8.0-gd \
       php8.0-zip php8.0-curl php8.0-xdebug \
       php8.0-imap php8.0-mysql php8.0-mbstring \
       php8.0-xml php8.0-xmlrpc php8.0-bcmath \
       php8.0-intl php8.0-readline php8.0-pcov \
       php8.0-msgpack php8.0-igbinary php8.0-ldap \
       php8.0-redis php8.0-swoole php8.0-fpm \
       php8.0-imagick php8.0-mongodb php8.0-ctype \
       php8.0-soap php8.0-tidy  \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configure php
COPY php.ini /etc/php/8.0/fpm/php.ini
COPY php-fpm.conf /etc/php/8.0/fpm/php-fpm.conf

# Configure nginx
COPY nginx-laravel.conf /etc/nginx/sites-enabled/

# Configure ssh keys
COPY .ssh/id_rsa /root/.ssh/id_rsa
COPY .ssh/id_rsa.pub /root/.ssh/id_rsa.pub
COPY .ssh/known_hosts /root/.ssh/known_hosts

RUN mkdir -p /var/www/.ssh/ && \
    cp /root/.ssh/* /var/www/.ssh/ && \
    chmod -R 0700 /var/www/.ssh && \
    chmod -R 0600 /var/www/.ssh/id_rsa && \
    chown -R www-data:www-data /var/www/.ssh

RUN mkdir -p /run/php/ && \
    mkdir -p /var/www/.cache/dconf/ && \
    mkdir -p /var/www/.config && \
    chown -R www-data:www-data /var/www/.cache && chmod 775 -R /var/www/.cache && \
    chown -R www-data:www-data /var/www/.config && chmod 775 -R /var/www/.config

EXPOSE 80
COPY docker_process.sh docker_process.sh
CMD ./docker_process.sh --project-php=hermes
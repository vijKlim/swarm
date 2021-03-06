FROM php:7.3-fpm

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get update && apt-get install -y \
        htop \
        cron \
        supervisor \
        nginx \
        redis-server \
        libpq-dev \
        libevent-dev \
        libxml2-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        imagemagick \
        libmagickwand-dev \
        libmcrypt-dev \
        libpng-dev \
        libcurl4-openssl-dev \
        libzip-dev \
        libssl-dev \
        libicu-dev \
        libxslt-dev \
        libmemcached-dev  \
        openssl \
        zlib1g-dev \
        wget  \
        git \
        librabbitmq-dev \
    && docker-php-ext-install curl iconv mbstring pdo pdo_pgsql pgsql zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-configure xsl \
    && docker-php-ext-install xsl

RUN pecl install amqp && docker-php-ext-enable amqp
RUN pecl install swoole-4.5.7 && docker-php-ext-enable swoole
RUN pecl install redis-5.3.2 && docker-php-ext-enable redis


COPY crontab /etc/cron.d/uniapp
RUN chmod 0644 /etc/cron.d/uniapp
RUN crontab /etc/cron.d/uniapp

COPY supervisor/supervisord.conf /etc/supervisor/supervisord.conf
COPY supervisor/swoole-jobs.conf /etc/supervisor/conf.d/swoole-jobs.conf

COPY nginx/nginx.conf /etc/nginx/nginx.conf

ENV COMPOSER_ALLOW_SUPERUSER 1

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer --quiet

WORKDIR /app

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]

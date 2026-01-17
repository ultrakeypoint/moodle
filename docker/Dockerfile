FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    libpq-dev \
    libicu-dev \
    libpng-dev \
    libzip-dev \
    libxml2-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
    pgsql \
    pdo_pgsql \
    intl \
    gd \
    zip \
    xml \
    soap \
    opcache \
    exif \
    && pecl install apcu \
    && docker-php-ext-enable apcu

# PHP 설정 파일 복사
COPY php/php.ini /usr/local/etc/php/php.ini

# Apache 설정 파일 복사
COPY apache/000-default.conf /etc/apache2/sites-available/000-default.conf

# Apache 사이트 활성화
RUN a2ensite 000-default

# Apache 모듈 활성화
RUN a2enmod rewrite deflate expires

# Composer 설치
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 엔트리포인트 스크립트 복사
COPY moodle/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /var/www/html

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["apache2-foreground"]
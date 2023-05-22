FROM php:7.4-fpm-alpine

RUN apk update && apt-get install -y \
    docker-php-ext-install pdo pdo_mysql \
    curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app
COPY . .
RUN composer install

CMD php artisan serve --host=0.0.0.0

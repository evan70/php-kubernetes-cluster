# Použite základný image PHP s FPM na Alpine
FROM php:8.2-fpm-alpine

# Skopírujte Composer z jeho oficiálneho image
COPY --from=composer:2.7 /usr/bin/composer /usr/local/bin/composer

# Nainštalujte potrebné balíky a povolenia pre SQLite
RUN apk --no-cache add \
        sqlite-dev \
    && docker-php-ext-install pdo_sqlite
    
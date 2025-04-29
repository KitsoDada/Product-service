# Build stage
FROM composer:2 as builder
WORKDIR /app
COPY . .
RUN composer install --no-dev --optimize-autoloader

# Runtime stage
FROM php:8.2-apache
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    netcat-openbsd \
    && docker-php-ext-install zip pdo pdo_mysql

# Copy built app files from the builder stage
COPY --from=builder /app .

# Copy Apache config
COPY .docker/apache.conf /etc/apache2/sites-available/000-default.conf

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set permissions for Laravel storage and cache
RUN chown -R www-data:www-data storage bootstrap/cache

# Copy and set entrypoint
COPY .docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

EXPOSE 80

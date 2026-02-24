FROM php:8.2-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    curl \
    libzip-dev \
    libpq-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libicu-dev \
    dos2unix \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Clear cache (Handled in previous RUN command)

# Install extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install pdo_mysql pdo_pgsql mbstring exif pcntl bcmath gd zip intl

# Enable mod_rewrite
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy composer binary
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy project files
COPY . .

# Ensure unix line endings and executable permission
RUN dos2unix docker-entrypoint.sh && \
    chmod +x docker-entrypoint.sh

# Install dependencies without running scripts (to avoid DB connection errors during build)
RUN composer install --no-dev --optimize-autoloader --no-scripts

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Configure Apache DocumentRoot to point to public
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Expose port 80
EXPOSE 80

# Start Application via Entrypoint script
COPY vcard-entrypoint.sh /usr/local/bin/
RUN dos2unix /usr/local/bin/vcard-entrypoint.sh && chmod +x /usr/local/bin/vcard-entrypoint.sh
ENTRYPOINT ["vcard-entrypoint.sh"]

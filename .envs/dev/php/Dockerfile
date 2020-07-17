FROM php:7.4-fpm

# Arguments defined in docker-compose.yml

ARG USERID=1001
ARG GROUPID=1001

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    sudo

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/app

COPY php/*.sh /scripts/

RUN chmod a+x /scripts/*.sh

# Create new username: php-fpm
RUN useradd -ms /bin/bash php-fpm --no-log-init
# Modify php-fpm user_id:group_id to current host_user_id:host_group_id
RUN usermod -u $USERID php-fpm
RUN groupmod -g $GROUPID php-fpm || exit 0

# Make php-fpm user can sudo without password
RUN sudo echo "php-fpm ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/php-fpm

USER php-fpm

EXPOSE 9000

ENTRYPOINT ["/scripts/entrypoint.sh"]

CMD ["/scripts/command.sh"]

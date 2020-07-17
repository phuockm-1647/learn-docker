#!/bin/bash

sudo chmod -R 777 storage/ bootstrap/cache/

# Copy development environment file if not existing
if [[ ! -f /var/www/app/.env && -f /var/www/app/.env.example ]]; then
  cp /var/www/app/.env.example /var/www/app/.env
fi

vendorDir=/var/www/app/vendor

# Install composer if it not existing
if [[ ! -d $vendorDir ]]; then
  composer install
fi

# Generate application key if it not set
APP_KEY=$(cat .env | sed -n 's/^APP_KEY=/ /p')
if [[ -z "${APP_KEY// }" ]]; then
  php artisan key:generate
fi

vendorOwner=$(stat -c '%U' $vendorDir)
if [ "$vendorOwer" != "php-fpm" ]; then
  # Change owner of $vendorDir directory to user phuoc
  sudo chown -R php-fpm:php-fpm $vendorDir
fi

# Discovery new packages and generate manifest
composer dump-autoload

exec "$@"

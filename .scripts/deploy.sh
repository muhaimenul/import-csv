#!/bin/bash
set -e

echo "Deployment started ..."

# Enter maintenance mode or return true
# if already is in maintenance mode
(php artisan down) || true

# Pull the latest version of the app
git pull origin master


# Install composer dependencies
sudo composer install --no-dev --no-interaction --prefer-dist --optimize-autoloader

# Directory Permissions
sudo chmod -R 777 storage bootstrap/cache

# Prepare .env if not exists
if [ ! -f .env ]
then
	cp .env.example .env
    php artisan key:generate
fi

# Clear the old cache
php artisan clear-compiled

# Recreate cache
php artisan optimize

# Install npm assets
# npm install

# Compile npm assets
# npm run prod

# Run database migrations
# php artisan migrate --force

# Exit maintenance mode
php artisan up

echo "Deployment finished!"

#!/bin/bash

# Install Symfony if the folder folder not exists
if [[ ! -d "/var/www/html/symfony/bin" ]]; then
  echo "Symfony installation"
  composer create-project symfony/website-skeleton:"^4.4" .
  composer require form validator apache-pack profiler-pack
else
  echo "Symfony project already exists"
fi

php -v
composer --version

exec "$@"
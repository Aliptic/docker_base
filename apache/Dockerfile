# Download the apache server
FROM php:7.4-apache

WORKDIR /var/www/html/

# Apt update and installation
RUN apt-get update && \
    apt-get install -y \
        git \
        nano \
        unzip \
        libzip-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set timezone
## v1
# RUN  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
#     && echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen \
#     && locale-gen
## v2
RUN rm /etc/localtime && \
    ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

# Apache
# COPY index.html /var/www/test/index.html
COPY vhost.conf /etc/apache2/sites-available/000-default.conf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
a2enmod rewrite 
# && service apache2 restart && chown -R 775 /var/www/html \

# Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN composer self-update

# Php configuration
RUN docker-php-ext-install pdo pdo_mysql zip

# Alias
# RUN echo 'alias sf="php bin/app/console"' >> ~/.bashrc
RUN printf 'alias sf="php bin/console"\nalias sf:m:c="php bin/console make:controller"\n' >> ~/.bashrc
# alias pv="php -v' >> ~/.bashrc

# RUN cat >> ~/.bashrc <<EOF
#     'alias sf="php bin/app/console"'
# EOF

# Symfony installation
# CMD ["/bin/bash","composer create-project symfony/website-skeleton:'^4.4' symfony"]
# CMD ["/usr/bin/composer", "--version"]
# RUN composer create-project symfony/website-skeleton:"^4.4" /symfony

# Entrypoint
# RUN chmod +x entrypoint.sh
## copy the file  in the container
COPY entrypoint.sh /usr/local/bin/

## add a new entrypoint 
ENTRYPOINT ["entrypoint.sh"]

## execute apache in background du to entrypoint
CMD ["apache2-foreground"]
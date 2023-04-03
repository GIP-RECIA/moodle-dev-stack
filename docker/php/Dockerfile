ARG PHP_IMG_VERSION

FROM ${PHP_IMG_VERSION}
 
ARG USER_ID
ARG GROUP_ID
ARG WEB_USER
ARG WEB_GROUP
ARG PHP_DATA_DIR
ARG PHP_PHPU_DATA_DIR
ARG PHP_ROOT_DIR
 
# Set TIMEZONE
ENV TZ=Europe/Paris
RUN apk update && apk upgrade \
    && apk add --no-cache --virtual .userGroupUpdateAndTzdata shadow tzdata \
    && usermod -u ${USER_ID} ${WEB_USER} && groupmod -g ${GROUP_ID} ${WEB_GROUP} \
    && chown -R ${WEB_USER}:${WEB_GROUP} ${PHP_ROOT_DIR}/php-fpm.d/www.conf \
    && echo $TZ > /etc/timezone \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime \
    && apk del .userGroupUpdateAndTzdata ${DEL_PKGS} \
    && apk add --no-cache $PHPIZE_DEPS icu-dev libpng-dev libxml2-dev libzip-dev \
    && pecl install igbinary redis \
#    && pecl install xdebug \
    && docker-php-ext-configure exif \
    && docker-php-ext-install exif gd intl mysqli opcache soap xmlrpc zip \
    && docker-php-ext-enable exif igbinary redis \
#    &&  docker-php-ext-enable xdebug \
    && apk add --no-cache ghostscript
# Installation de composer
RUN curl -s https://getcomposer.org/installer | php \
    && alias composer='php composer.phar'
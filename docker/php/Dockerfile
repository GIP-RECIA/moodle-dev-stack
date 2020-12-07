ARG PHP_IMG_VERSION

FROM ${PHP_IMG_VERSION}
 
ARG USER_ID
ARG GROUP_ID
ARG WEB_USER
ARG WEB_GROUP
ARG PHP_DATA_DIR
ARG PHP_ROOT_DIR
 
RUN apk update && apk upgrade \
    && apk add --no-cache --virtual .userAndGroupUpdate shadow \
    && usermod -u ${USER_ID} ${WEB_USER} && groupmod -g ${GROUP_ID} ${WEB_GROUP} \
    && chown -R ${WEB_USER}:${WEB_GROUP} ${PHP_ROOT_DIR}/php-fpm.d/www.conf \
    && apk del .userAndGroupUpdate ${DEL_PKGS} \
    && apk add --no-cache icu-dev libpng-dev libxml2-dev libzip-dev \
    && docker-php-ext-install gd intl mysqli opcache soap xmlrpc zip

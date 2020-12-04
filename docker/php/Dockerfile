ARG PHP_IMG_VERSION

FROM ${PHP_IMG_VERSION}
 
ARG USER_ID
ARG GROUP_ID
ARG WEB_USER
ARG WEB_GROUP
ARG PHP_ROOT_DIR
 
RUN apk update && apk upgrade \
    && apk add --no-cache --virtual .userAndGroupUpdate shadow \
    && chgrp -R ${WEB_USER} ${PHP_ROOT_DIR}/php-fpm.d/www.conf \
    && usermod -u ${USER_ID} ${WEB_USER} && groupmod -g ${GROUP_ID} ${WEB_GROUP} \
    && apk del .userAndGroupUpdate ${DEL_PKGS} \
    && docker-php-ext-install mysqli

ARG APACHE_IMG_VERSION

FROM ${APACHE_IMG_VERSION}
 
ARG USER_ID
ARG GROUP_ID
ARG WEB_USER
ARG WEB_GROUP
ARG APACHE_ROOT_DIR
 
RUN apk update && apk upgrade \
    && apk add --no-cache --virtual .userAndGroupUpdate shadow \
    && apk add --no-cache libcap \
    && usermod -u ${USER_ID} ${WEB_USER} && groupmod -g ${GROUP_ID} ${WEB_GROUP} \
    && chgrp -R ${WEB_GROUP} ${APACHE_ROOT_DIR} \
    #Change access righs to conf, logs, bin from root to www-data
    && chown -hR ${WEB_USER}:${WEB_GROUP} ${APACHE_ROOT_DIR} \
    && apk del .userAndGroupUpdate ${DEL_PKGS} \
    #setcap to bind to privileged ports as non-root
    && setcap 'cap_net_bind_service=+ep' ${APACHE_ROOT_DIR}/bin/httpd \
    && getcap ${APACHE_ROOT_DIR}/bin/httpd

HEALTHCHECK --interval=60s --timeout=30s CMD nc -zv localhost 80 || exit 1

#Run as a www-data
USER ${WEB_USER}
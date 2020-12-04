ARG MARIADB_IMG_VERSION

FROM ${MARIADB_IMG_VERSION}

ARG GROUP_ID
ARG USER_ID
ARG MARIADB_CONTAINER_USER
ARG MARIADB_CONTAINER_GROUP
 
# Fix permissions to match host user
RUN usermod -u ${USER_ID} ${MARIADB_CONTAINER_USER} && groupmod -g ${GROUP_ID} ${MARIADB_CONTAINER_GROUP}

# set locales
RUN apt-get update && apt-get install -y \
    apt-utils \
    locales
RUN locale-gen fr_FR.UTF-8
ENV LANG fr_FR.UTF-8
ENV LC_CTYPE fr_FR.UTF-8

# Set TIMEZONE
ENV TZ=Europe/Paris
RUN echo $TZ > /etc/timezone && \
    apt-get update && apt-get install -y tzdata && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean

EXPOSE 3306
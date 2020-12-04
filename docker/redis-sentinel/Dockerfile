ARG SENTINEL_IMG_VERSION

FROM ${SENTINEL_IMG_VERSION}
 
RUN mkdir -p /redis
 
WORKDIR /redis
 
COPY conf/sentinel.conf .
COPY sentinel-entrypoint.sh /usr/local/bin/
 
RUN chown redis:redis /redis/* && \
    chmod +x /usr/local/bin/sentinel-entrypoint.sh
 
EXPOSE 26379
 
ENTRYPOINT ["sentinel-entrypoint.sh"]
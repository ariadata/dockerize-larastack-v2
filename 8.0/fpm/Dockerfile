FROM ariadata/php-8.0:cli

LABEL maintainer="AriaData (@ariadata)"

# Install FPM
RUN apt-get update \
    && apt-get -y --no-install-recommends install php8.0-fpm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Copy over S6 configurations
COPY etc/services.d/ /etc/services.d/
COPY etc/cont-init.d/ /etc/cont-init.d/

# Apply PHP configuration files
COPY etc/php/fpm/ /etc/php/8.0/fpm/

# Logrotate
# COPY etc/logrotate.d/php8.0-fpm /etc/logrotate.d/php8.0-fpm
RUN rm /etc/logrotate.d/php8.0-fpm

ENTRYPOINT ["/init" ]

################################################################
# Commenting these out for now because Traefik and Swarm
# we not playing well together with this for rolling updates

# HEALTHCHECK --start-period=5s \
#   CMD curl -f http://127.0.0.1:9000/ping/ || exit 1

# Open up fcgi port
EXPOSE 9000
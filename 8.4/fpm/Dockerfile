FROM ariadata/php-8.4:cli

LABEL maintainer="AriaData (@ariadata)"

# Install PHP-FPM
RUN apt-get update \
    && apt-get -y --no-install-recommends install php8.4-fpm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Copy over S6 configurations
COPY etc/services.d/ /etc/services.d/
COPY etc/cont-init.d/ /etc/cont-init.d/

# Apply PHP-FPM configuration files
COPY etc/php/fpm/ /etc/php/8.4/fpm/

# Copy PHP configuration overrides
COPY etc/php/90-override.ini /etc/php/8.4/fpm/conf.d/

# Logrotate: Remove default PHP-FPM logrotate configuration
RUN rm /etc/logrotate.d/php8.4-fpm

# Configure S6 as the entrypoint
ENTRYPOINT ["/init"]

################################################################
# Commenting these out for now because Traefik and Swarm
# were not playing well together with this for rolling updates

# HEALTHCHECK --start-period=5s \
#   CMD curl -f http://127.0.0.1:9000/ping/ || exit 1

# Expose the FastCGI port
EXPOSE 9000
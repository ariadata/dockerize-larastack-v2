FROM ariadata/php-8.2:cli

LABEL maintainer="AriaData (@ariadata)"


RUN apt-get update \
    && apt-get -y --no-install-recommends install supervisor \
    && mkdir -p /var/supervisor/ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Copy over S6 configurations
COPY etc/services.d/ /etc/services.d/
COPY etc/cont-init.d/ /etc/cont-init.d/
COPY etc/supervisor/ /etc/supervisor/

ENTRYPOINT ["/init" ]
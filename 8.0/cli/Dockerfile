FROM ariadata/baseimage-s6-overlay-ubuntu-20:jammy

LABEL maintainer="AriaData (@ariadata)"

ENV DEBIAN_FRONTEND=noninteractive \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    WEBUSER_HOME="/var/www/html" \
    PUID=9999 \
    PGID=9999

# Install PHP from packages.sury.org (canonical; newer than Launchpad PPA), composer and selected extensions
# Note: php8.0-swoole is not published on packages.sury.org (available on Launchpad PPA only for <8.2).
RUN apt-get update \
    && groupadd -r -g $PGID webgroup \
    && useradd --no-log-init -r -s /usr/bin/bash -d $WEBUSER_HOME -u $PUID -g $PGID webuser \
    && apt-get install -y --no-install-recommends ca-certificates curl \
    && curl -fsSLo /tmp/debsuryorg-archive-keyring.deb https://packages.sury.org/debsuryorg-archive-keyring.deb \
    && dpkg -i /tmp/debsuryorg-archive-keyring.deb \
    && echo "deb [signed-by=/usr/share/keyrings/debsuryorg-archive-keyring.gpg] https://packages.sury.org/php/ jammy main" > /etc/apt/sources.list.d/php-sury.list \
    && apt-get update \
    && apt-get -y --no-install-recommends install logrotate cron \
    && apt-get -y --no-install-recommends install \
        ca-certificates git curl unzip \
        php8.0-cli \
		php8.0-dev \
		php8.0-mysql \
		php8.0-mongodb \
		php8.0-redis \
		php8.0-pgsql \
		php8.0-sqlite3 \
		php8.0-amqp \
		php8.0-rdkafka \
		php8.0-gd \
		php8.0-curl \
		php8.0-memcached \
		php8.0-imap \
		php8.0-mbstring \
		php8.0-xml \
		php8.0-zip \
		php8.0-soap \
		php8.0-intl \
		php8.0-readline \
		php8.0-pcov \
		php8.0-msgpack \
		php8.0-igbinary \
		php8.0-ldap \
		php8.0-apcu \
		php8.0-opcache \
		php8.0-bcmath \
		php8.0-gmp \
		php8.0-imagick \
		php8.0-exif \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy over S6 configurations
COPY etc/cont-init.d/ /etc/cont-init.d/

COPY etc/php/ /etc/php/8.0/cli/conf.d/

# Cron: Remove defaults
RUN rm -rf /etc/cron.d/* /etc/cron.daily/* /etc/cron.hourly/* /etc/cron.monthly/* /etc/cron.weekly/*

# Logrotate
COPY etc/cron.daily/logrotate /etc/cron.daily/logrotate
RUN chmod +x /etc/cron.daily/logrotate
RUN rm -rf /etc/logrotate.d/*

RUN mkdir /etc_custom/

# Set the default work directory to our web user
WORKDIR /var/www/html

#Configure S6 to drop priveleges
ENTRYPOINT ["/init"]

# Run PHP
CMD ["php", "-a"]
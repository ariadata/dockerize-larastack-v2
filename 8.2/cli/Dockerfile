FROM ariadata/baseimage-s6-overlay-ubuntu-20:jammy

LABEL maintainer="AriaData (@ariadata)"

ENV DEBIAN_FRONTEND=noninteractive \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    WEBUSER_HOME="/var/www/html" \
    PUID=9999 \
    PGID=9999

# Install Ondrej repos for Ubuntu jammy, PHP8.2, composer and selected extensions
RUN apt-get update \
    && groupadd -r -g $PGID webgroup \
    && useradd --no-log-init -r -s /usr/bin/bash -d $WEBUSER_HOME -u $PUID -g $PGID webuser \
    && apt-get install -y --no-install-recommends gnupg \
    && echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu jammy main" > /etc/apt/sources.list.d/ondrej-php.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C \
    && apt-get update \
    && apt-get -y --no-install-recommends install logrotate cron \
    && apt-get -y --no-install-recommends install \
        ca-certificates git curl unzip \
        php8.2-cli \
		php8.2-dev \
		php8.2-mysql \
		php8.2-mongodb \
		php8.2-redis \
		php8.2-pgsql \
		php8.2-sqlite3 \
		php8.2-amqp \
		php8.2-rdkafka \
		php8.2-gd \
		php8.2-curl \
		php8.2-memcached \
		php8.2-imap \
		php8.2-mbstring \
		php8.2-xml \
		php8.2-zip \
		php8.2-soap \
		php8.2-intl \
		php8.2-readline \
		php8.2-pcov \
		php8.2-msgpack \
		php8.2-igbinary \
		php8.2-ldap \
		php8.2-swoole \
		php8.2-apcu \
		php8.2-opcache \
		php8.2-bcmath \
		php8.2-gmp \
		php8.2-imagick \
		php8.2-exif \
		php8.2-exif \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy over S6 configurations
COPY etc/cont-init.d/ /etc/cont-init.d/

COPY etc/php/ /etc/php/8.2/cli/conf.d/

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
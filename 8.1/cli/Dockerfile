FROM ariadata/baseimage-s6-overlay-ubuntu-20

LABEL maintainer="AriaData (@ariadata)"

ENV DEBIAN_FRONTEND=noninteractive \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    WEBUSER_HOME="/var/www/html" \
    PUID=9999 \
    PGID=9999

# Install Ondrej repos for Ubuntu focal, PHP8.1, composer and selected extensions
RUN apt-get update \
    && groupadd -r -g $PGID webgroup \
    && useradd --no-log-init -r -s /usr/bin/bash -d $WEBUSER_HOME -u $PUID -g $PGID webuser \
    && apt-get install -y --no-install-recommends gnupg \
    && echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu focal main" > /etc/apt/sources.list.d/ondrej-php.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C \
    && apt-get update \
    && apt-get -y --no-install-recommends install logrotate cron \
    && apt-get -y --no-install-recommends install \
        ca-certificates git curl unzip \
        php8.1-cli \
		php8.1-dev \
		php8.1-mysql \
		php8.1-mongodb \
		php8.1-redis \
		php8.1-pgsql \
		php8.1-sqlite3 \
		php8.1-gd \
		php8.1-curl \
		php8.1-memcached \
		php8.1-imap \
		php8.1-mbstring \
		php8.1-xml \
		php8.1-zip \
		php8.1-soap \
		php8.1-intl \
		php8.1-readline \
		php8.1-pcov \
		php8.1-msgpack \
		php8.1-igbinary \
		php8.1-ldap \
		php8.1-swoole \
		php8.1-apcu \
		php8.1-opcache \
		php8.1-bcmath \
		php8.1-gmp \
		php8.1-imagick \
		php8.1-exif \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy over S6 configurations
COPY etc/cont-init.d/ /etc/cont-init.d/

COPY etc/php/ /etc/php/8.1/cli/conf.d/

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
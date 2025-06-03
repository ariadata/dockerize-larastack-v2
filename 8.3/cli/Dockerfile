FROM ariadata/baseimage-s6-overlay-ubuntu-20:v2

LABEL maintainer="AriaData (@ariadata)"

ENV DEBIAN_FRONTEND=noninteractive \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    WEBUSER_HOME="/var/www/html" \
    PUID=9999 \
    PGID=9999

# Install Ondrej repos for Ubuntu focal, PHP8.3, composer and selected extensions
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
        php8.3-cli \
		php8.3-dev \
		php8.3-mysql \
		php8.3-mongodb \
		php8.3-redis \
		php8.3-pgsql \
		php8.3-sqlite3 \
		php8.3-amqp \
		php8.3-rdkafka \
		php8.3-gd \
		php8.3-curl \
		php8.3-memcached \
		php8.3-imap \
		php8.3-mbstring \
		php8.3-xml \
		php8.3-zip \
		php8.3-soap \
		php8.3-intl \
		php8.3-readline \
		php8.3-pcov \
		php8.3-msgpack \
		php8.3-igbinary \
		php8.3-ldap \
		php8.3-swoole \
		php8.3-apcu \
		php8.3-opcache \
		php8.3-bcmath \
		php8.3-gmp \
		php8.3-imagick \
		php8.3-exif \
		php8.3-exif \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy over S6 configurations
COPY etc/cont-init.d/ /etc/cont-init.d/

COPY etc/php/ /etc/php/8.3/cli/conf.d/

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
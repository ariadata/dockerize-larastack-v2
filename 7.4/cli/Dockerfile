FROM ariadata/baseimage-s6-overlay-ubuntu-20:v2

LABEL maintainer="AriaData (@ariadata)"

ENV DEBIAN_FRONTEND=noninteractive \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    WEBUSER_HOME="/var/www/html" \
    PUID=9999 \
    PGID=9999

# Install Ondrej repos for Ubuntu focal, php7.4, composer and selected extensions
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
        php7.4-cli \
		php7.4-dev \
		php7.4-mysql \
		php7.4-mongodb \
		php7.4-redis \
		php7.4-pgsql \
		php7.4-sqlite3 \
		php7.4-amqp \
		php7.4-rdkafka \
		php7.4-gd \
		php7.4-curl \
		php7.4-memcached \
		php7.4-imap \
		php7.4-mbstring \
		php7.4-xml \
		php7.4-zip \
		php7.4-soap \
		php7.4-intl \
		php7.4-readline \
		php7.4-pcov \
		php7.4-msgpack \
		php7.4-igbinary \
		php7.4-ldap \
		php7.4-swoole \
		php7.4-apcu \
		php7.4-opcache \
		php7.4-bcmath \
		php7.4-gmp \
		php7.4-imagick \
		php7.4-exif \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy over S6 configurations
COPY etc/cont-init.d/ /etc/cont-init.d/

COPY etc/php/ /etc/php/7.4/cli/conf.d/

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
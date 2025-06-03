ARG PHP_VERSION=8.4
FROM ariadata/php-${PHP_VERSION}:fpm

LABEL maintainer="AriaData (@ariadata)"

# Environment variables for Node.js and Yarn
ENV NODE_VERSION=21.6.1 \
    YARN_VERSION=1.22.19 \
    ARCH=x64

# Install Nginx and dependencies
RUN apt-get update \
    && echo "Install requirements..." \
    && apt-get -y --no-install-recommends install curl gnupg2 ca-certificates lsb-release \
    && curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/ubuntu $(lsb_release -cs) nginx" | tee /etc/apt/sources.list.d/nginx.list \
    && apt-get update && apt-get -y --no-install-recommends install nginx \
    && echo "Fixing permissions issues on the webroot..." \
    && chown -R webuser:webgroup /var/www/html/ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* /var/www/html/*

# Install Node.js
RUN export GNUPGHOME="$(mktemp -d)" && set -ex \
    && apt-get update \
    && apt-get install -y xz-utils \
    && rm -rf /var/lib/apt/lists/* \
    && for key in \
        4ED778F539E3634C779C87C6D7062848A1AB005C \
        141F07595B7B3FFE74309A937405533BE57C7D57 \
        74F12602B6F1C4E913FAA37AD3A89613643B6201 \
        DD792F5973C6DE52C432CBDAC77ABFA00DDBF2B7 \
        890C08DB8579162FEE0DF9DB8BEAB4DFCF555EF4 \
    ; do \
        gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys "$key" || \
        gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$key" ; \
    done \
    && curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz" \
    && curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
    && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
    && gpgconf --kill all && rm -rf "$GNUPGHOME" \
    && grep " node-v$NODE_VERSION-linux-$ARCH.tar.xz$" SHASUMS256.txt | sha256sum -c - \
    && tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
    && rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
    && ln -s /usr/local/bin/node /usr/local/bin/nodejs \
    # Smoke tests
    && node --version \
    && npm --version

# Install Yarn
RUN export GNUPGHOME="$(mktemp -d)" && set -ex \
    # Use pre-existing gpg directory
    && for key in \
        6A010C5166006599AA17F08146C2130DFD2497F5 \
    ; do \
        gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys "$key" || \
        gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$key" ; \
    done \
    && curl -fsSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
    && curl -fsSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz.asc" \
    && gpg --batch --verify yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
    && gpgconf --kill all && rm -rf "$GNUPGHOME" \
    && mkdir -p /opt \
    && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/ \
    && ln -s /opt/yarn-v$YARN_VERSION/bin/yarn /usr/local/bin/yarn \
    && ln -s /opt/yarn-v$YARN_VERSION/bin/yarnpkg /usr/local/bin/yarnpkg \
    && rm yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
    # Smoke test
    && yarn --version

# Configure npm cache
RUN npm config set cache /tmp --global

# Copy over S6 configurations
COPY etc/services.d/ /etc/services.d/
COPY etc/cont-init.d/ /etc/cont-init.d/

# Copy Nginx configurations
COPY etc/nginx/ /etc/nginx/

# Copy PHP-FPM pool configurations
COPY etc/php/fpm/pool.d/ /etc/php/${PHP_VERSION}/fpm/pool.d/

# Expose ports for HTTP, HTTPS, and development server
EXPOSE 80
EXPOSE 443
EXPOSE 5173
EXPOSE 8080

# Set S6 as the entrypoint
ENTRYPOINT ["/init"]
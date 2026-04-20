ARG PHP_VERSION=8.5
FROM ariadata/php-${PHP_VERSION}:fpm

LABEL maintainer="AriaData (@ariadata)"

# Environment variables for Node.js
ENV NODE_VERSION=24.15.0 \
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

# Install Node.js (release keys aligned with https://github.com/nodejs/docker-node — includes EDDSA used for current SHASUMS256.txt.asc)
RUN export GNUPGHOME="$(mktemp -d)" && set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends xz-utils dirmngr \
    && rm -rf /var/lib/apt/lists/* \
    && for key in \
        5BE8A3F6C8A5C01D106C0AD820B1A390B168D356 \
        DD792F5973C6DE52C432CBDAC77ABFA00DDBF2B7 \
        CC68F5A3106FF448322E48ED27F5E38D5B0A215F \
        8FCCA13FEF1D0C2E91008E09770F7A9A5AE15600 \
        890C08DB8579162FEE0DF9DB8BEAB4DFCF555EF4 \
        C82FA3AE1CBEDC6BE46B9360C43CEC45C17AB93C \
        108F52B48DB57BB0CC439B2997B01419BD92F80A \
        A363A499291CBBC940DD62E41F10027AF002F8B0 \
    ; do \
        { gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys "$key" && gpg --batch --fingerprint "$key"; } || \
        { gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$key" && gpg --batch --fingerprint "$key"; } ; \
    done \
    && curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz" \
    && curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
    && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
    && gpgconf --kill all && rm -rf "$GNUPGHOME" \
    && grep " node-v$NODE_VERSION-linux-$ARCH.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
    && tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
    && rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
    && ln -s /usr/local/bin/node /usr/local/bin/nodejs \
    && node --version \
    && npm --version

# Yarn via Corepack (ships with Node; avoids brittle GPG/tarball verification for classic Yarn releases)
RUN corepack enable \
    && corepack prepare yarn@stable --activate \
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
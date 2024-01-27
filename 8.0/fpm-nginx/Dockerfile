ARG PHP_VERSION=8.0
FROM ariadata/php-${PHP_VERSION}:fpm

LABEL maintainer="AriaData (@ariadata)"

ENV NODE_VERSION 21.5.0
ENV YARN_VERSION 1.22.19
ENV ARCH x64

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
	# smoke tests
	&& node --version \
	&& npm --version

RUN export GNUPGHOME="$(mktemp -d)" && set -ex \
	# use pre-existing gpg directory, see https://github.com/nodejs/docker-node/pull/1895#issuecomment-1550389150
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
	# smoke test
	&& yarn --version

RUN npm config set cache /tmp --global

# COPY over S6 configurations
COPY etc/services.d/ /etc/services.d/
COPY etc/cont-init.d/ /etc/cont-init.d/

#NGINX: Set server configs
COPY etc/nginx/ /etc/nginx/

#PHP: Copy PHP configurations
COPY etc/php/${PHP_VERSION}/fpm/pool.d/ /etc/php/${PHP_VERSION}/fpm/pool.d/

EXPOSE 80
EXPOSE 443
EXPOSE 5173

ENTRYPOINT ["/init"]

FROM ariadata/php-7.4:fpm

LABEL maintainer="AriaData (@ariadata)"


# Install NGINX (web), MSMTP (email client), and Supervisor (process management)
RUN apt-get update \
	&& echo "Install requirements..." \
	&& apt-get -y --no-install-recommends install curl gnupg2 ca-certificates lsb-release \ 
	&& curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null \
	&& echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" | tee /etc/apt/sources.list.d/nginx.list \
	&& apt-get update && apt-get -y --no-install-recommends install nginx \
	&& echo "Fixing permissions issues on the webroot..." \
	&& chown -R webuser:webgroup /var/www/html/ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* /var/www/html/*

# Install NPM + YARN
RUN curl -sLS https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN npm config set cache /tmp --global

# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarn.gpg >/dev/null \
#        && echo "deb [signed-by=/usr/share/keyrings/yarn.gpg] https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list \
#        && apt-get update && apt-get install -y yarn

# RUN yarn config set cache-folder /tmp


# Copy over S6 configurations
COPY etc/services.d/ /etc/services.d/
COPY etc/cont-init.d/ /etc/cont-init.d/

#NGINX: Set server configs
COPY etc/nginx/ /etc/nginx/

#PHP: Copy PHP configurations
COPY etc/php/fpm/pool.d/ /etc/php/7.4/fpm/pool.d/

# Logrotate
# COPY etc/logrotate.d/nginx /etc/logrotate.d/nginx
RUN rm /etc/logrotate.d/nginx

EXPOSE 80
EXPOSE 443
EXPOSE 5173

################################################################
# Commenting these out for now because Traefik and Swarm
# we not playing well together with this for rolling updates

# HEALTHCHECK --start-period=5s \
#   CMD curl -k -f https://127.0.0.1/ping/ || exit 1

ENTRYPOINT ["/init"]
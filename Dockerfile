FROM alpine

MAINTAINER Egor Danko <qwertyone@gmail.com>

# Install required packages
RUN apk --no-cache add rtorrent dtach s6 lighttpd php5-fpm php5-cli php5-json tar

# Enable php-fpm in lighttpd
RUN sed -i "s/#   include \"mod_fastcgi_fpm.conf\"/   include \"mod_fastcgi_fpm.conf\"/g" /etc/lighttpd/lighttpd.conf

# Make php-fpm run from lighttpd user
RUN sed -i "s/user = nobody/user = lighttpd/g" /etc/php/php-fpm.conf

# Get ruTorrent
RUN cd /var/www/localhost/htdocs/ && \
    #mkdir rutorrent && \
    curl -L -O https://github.com/Novik/ruTorrent/archive/master.tar.gz && \
    tar xzvf master.tar.gz -C . --strip-components 1 && \
    rm -rf *.tar.gz && \
    cd /var/www/localhost/htdocs/plugins && \
    mkdir mobile && \
    curl -L -O https://github.com/xombiemp/rutorrentMobile/archive/master.tar.gz && \
    tar xzvf master.tar.gz -C mobile --strip-components 1 && \
    rm -rf *.tar.gz

# Service directories and the wrapper script
ADD rootfs /

# Declare ports to expose
EXPOSE 80 9527/udp 45566

# Declare volumes
VOLUME /rtorrent

# Run
ENTRYPOINT ["startup"]

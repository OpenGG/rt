FROM alpine

MAINTAINER Egor Danko <qwertyone@gmail.com>

# Install required packages
RUN apk --no-cache add rtorrent dtach supervisor

# Run
ENTRYPOINT ["/bin/sh"]

#
# MiniDLNA Dockerfile
#
# https://github.com/umeice/minidlna
#

# Pull base image.
FROM umeice/python

MAINTAINER @bungoume <bungoume@gmail.com>

# Install MiniDLNA(ReadyMedia).
RUN \
  apt-get install build-essential libavutil-dev \
    libavcodec-dev libavformat-dev libjpeg-dev libsqlite3-dev libid3tag0-dev \
    libogg-dev libvorbis-dev libflac-dev gettext
RUN \
  cd /tmp && \
  wget http://jaist.dl.sourceforge.net/project/minidlna/minidlna/1.1.4/minidlna-1.1.4.tar.gz && \
  tar xvzf minidlna-1.1.4.tar.gz && \
  cd minidlna-1.1.4 && \
  ./configure && \
  make && make install
RUN \
  cd /tmp/minidlna-1.14 && \
  cp minidlna.conf /etc/ && \


# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
#CMD ["sbin"]

# Expose ports.
#   - 1900: UPnP
#   - 8200: HTTP
EXPOSE 1900/udp
EXPOSE 8200

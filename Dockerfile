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
  apt-get install -y build-essential libavutil-dev \
    libavcodec-dev libavformat-dev libjpeg-dev libsqlite3-dev libid3tag0-dev \
    libogg-dev libvorbis-dev libflac-dev libexif-dev gettext
RUN \
  cd /tmp && \
  wget http://jaist.dl.sourceforge.net/project/minidlna/minidlna/1.1.4/minidlna-1.1.4.tar.gz && \
  tar xvzf minidlna-1.1.4.tar.gz && \
  cd minidlna-1.1.4 && \
  ./configure && \
  make && make install


# add config file.
ADD minidlna.conf /etc/minidlna.conf


# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["/usr/local/sbin/minidlnad","-d"]

# Expose ports.
#   - 1900: UPnP
#   - 8200: HTTP
EXPOSE 1900/udp
EXPOSE 8200

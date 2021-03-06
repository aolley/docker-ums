FROM debian:jessie

RUN echo 'deb http://www.deb-multimedia.org jessie main non-free' >> /etc/apt/sources.list &&\
    dpkg --add-architecture i386 &&\
    apt-get update &&\
    apt-get install -y --force-yes deb-multimedia-keyring &&\
    apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    dcraw \
    ffmpeg \
    libfreetype6:i386 \
    libstdc++6:i386 \
    mediainfo \
    mencoder \
    mplayer \
    openjdk-7-jre \
    vlc \
    wget

ENV UMSVER 6.7.1
RUN (wget "http://sourceforge.net/projects/unimediaserver/files/Official%20Releases/Linux/UMS-${UMSVER}.tgz/download" -O /opt/UMS-${UMSVER}.tgz &&\
  cd /opt &&\
  tar zxf UMS-${UMSVER}.tgz &&\
  rm UMS-${UMSVER}.tgz &&\
  mv ums-${UMSVER} ums)

ADD UMS.conf /opt/ums/UMS.conf
ADD WEB.conf /opt/ums/WEB.conf

ENV UMS_PROFILE /opt/ums/UMS.conf
RUN (mkdir /opt/ums/database /opt/ums/data &&\
  groupadd -g 500 ums &&\
  useradd -u 500 -g 500 -d /opt/ums ums &&\
  chown -R ums:ums /opt/ums)

USER ums
WORKDIR /opt/ums
EXPOSE 1900/udp 2869 5001 9001
VOLUME ["/tmp","/opt/ums/database","/opt/ums/data"]
CMD ["/opt/ums/UMS.sh"]

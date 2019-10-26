FROM debian:buster
MAINTAINER Rahul Amaram

# mono-complete is needed for compiling OtpKeyProv plugin
# libgtk2.0-0 is needed to avoid a message of Gtk not found during docker run command
# netcat-openbsd, net-tools, iputils-ping and host are used for debugging
RUN apt-get update \
 && apt-get install -y ca-certificates wget unzip \
 && apt-get install -y keepass2 keepass2-doc keepass2-plugin-keepasshttp mono-complete \
 && apt-get install -y libgtk2.0-0 \
 && apt-get install -y netcat-openbsd net-tools iputils-ping host \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


WORKDIR /usr/lib/keepass2/Plugins
RUN wget -P /root https://keepass.info/extensions/v2/otpkeyprov/OtpKeyProv-2.6.zip \
  && unzip /root/OtpKeyProv-2.6.zip

WORKDIR /root
CMD /usr/bin/keepass2

FROM phusion/baseimage:0.10.2
LABEL maintainer="arturol76"

RUN	apt-get update \
	&& apt-get -y upgrade -o Dpkg::Options::="--force-confold" \
	&& apt-get -y dist-upgrade -o Dpkg::Options::="--force-confold"

#ART: nano editor
RUN apt-get -y install nano

#SSH
RUN rm -f /etc/service/sshd/down

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh


RUN	apt-get -y remove make && \
	apt-get -y clean && \
	apt-get -y autoremove && \
	rm -rf /tmp/* /var/tmp/*

EXPOSE 22

CMD ["/sbin/my_init"]
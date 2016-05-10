FROM ubuntu:16.04

RUN echo "deb http://de.archive.ubuntu.com/ubuntu xenial main multiverse" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
	make \
	unrar \
	autoconf \
	automake \
	libtool \
	gcc \
	g++ \
	gperf \
	flex \
	bison \
	texinfo \
	gawk \
	ncurses-dev \
	libexpat-dev \
	python \
	python-serial \
	sed \
	git \
	unzip \
	bash \
	libtool-bin \
	wget \
	bzip2 \
	vim \
	screen \
	sudo

RUN useradd -d /home/espbuilder -m espbuilder && \
	usermod -a -G dialout,staff espbuilder && \
	mkdir -p /etc/sudoers.d && \
	echo "espbuilder ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/espbuilder && \
	chmod 0440 /etc/sudoers.d/espbuilder

USER espbuilder

RUN cd /home/espbuilder && git clone --recursive https://github.com/pfalcon/esp-open-sdk.git
RUN cd /home/espbuilder/esp-open-sdk && make

# Cleanup
RUN rm -rf /home/espbuilder/esp-open-sdk/crosstool-NG/.build

ENV PATH /home/espbuilder/esp-open-sdk/xtensa-lx106-elf/bin:$PATH
ENV XTENSA_TOOLS_ROOT /home/espbuilder/esp-open-sdk/xtensa-lx106-elf/bin
ENV SDK_BASE /home/espbuilder/esp-open-sdk/sdk
ENV FW_TOOL /home/espbuilder/esp-open-sdk/xtensa-lx106-elf/bin/esptool.py

CMD (cd /home/espbuilder/ && /bin/bash)
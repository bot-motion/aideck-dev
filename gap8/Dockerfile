#FROM ubuntu:20.04
# Remember: if you upgrade, you run into problems with the OpenCV install
# easy to fix, but then you can't take the official github repo SDK
FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive 
ARG GAP_SDK_VERSION
RUN echo $GAP_SDK_VERSION

# Install python 3.7 / needed for tensorflow 1.15 which is compatible with GAP8 SDK 3.9.1.
# Beware: Ubuntu 20.04 is suggested for the SDK 3.9.1 but comes with Python 3.8 as the standard py install
#RUN apt update
#RUN apt install software-properties-common
#RUN add-apt-repository ppa:deadsnakes/ppa
#RUN apt install python3.7

# on Ubuntu 20.04 you also need
#RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10

# Install needed packages  [on Ubuntu 20.04 take out python3-pip]
RUN apt-get update && apt-get install -y build-essential git python3-pip libftdi-dev libftdi1 doxygen libsdl2-dev curl wget cmake libusb-1.0-0-dev scons gtkwave libsndfile1-dev rsync autoconf automake texinfo libtool pkg-config libsdl2-ttf-dev  libjpeg-dev


# Install gap8 openocd
RUN git clone https://github.com/GreenWaves-Technologies/gap8_openocd.git; cd gap8_openocd; ./bootstrap; ./configure --program-prefix=gap8- --prefix=/usr --datarootdir=/usr/share/gap8-openocd; make -j; make -j install

# Install toolchain
RUN git clone https://github.com/GreenWaves-Technologies/gap_riscv_toolchain_ubuntu_18.git; cd gap_riscv_toolchain_ubuntu_18 && ./install.sh "/usr/lib/gap_riscv_toolchain" && cd ..

# Install Gap SDK
RUN git clone https://github.com/GreenWaves-Technologies/gap_sdk.git; cd gap_sdk && git fetch --all --tags && git checkout tags/release-v${GAP_SDK_VERSION} && git submodule update --init --recursive

# RUN pip3 install -U pip 

RUN cd gap_sdk && python3 -m pip install -r requirements.txt

#RUN python3 -m pip install requests
#RUN python3 -m pip install configparser

# scons on Ubuntu 18.04 needs configparser and uses Python 2.7
RUN apt-get install -y python-pip
RUN python -m pip install configparser

#RUN which python; which python3; python --version; python3 --version; python3 -m pip install configparser

#RUN /bin/bash -c "echo 'alias python = python3' >> ~/.bashrc "

RUN /bin/bash -c "cd gap_sdk/; source configs/ai_deck.sh; ls; make all;"

#RUN pip3 install numpy
RUN python3 -m pip install tensorflow==1.15.2
RUN python3 -m pip install h5py==2.10.0

RUN cd gap_sdk/tools/nntool; python3 -m pip install -r requirements.txt

RUN /bin/bash -c "cd gap_sdk/; source configs/ai_deck.sh; ls; make nntool"

RUN apt-get install -y libopencv-dev python3-opencv

RUN /bin/bash -c "cd gap_sdk/; source configs/ai_deck.sh; ls; make gap_tools"

# Install RISC V GDB as per README by Greenwaves Technologies
RUN mkdir /usr/lib/risc64_elf_ubuntu_toolchain; cd /usr/lib/risc64_elf_ubuntu_toolchain
RUN wget https://github.com/riscv/riscv-gnu-toolchain/releases/download/2021.04.03/riscv64-elf-ubuntu-20.04-nightly-2021.04.03-nightly.tar.gz
RUN tar xzf  riscv64-elf-ubuntu-20.04-nightly-2021.04.03-nightly.tar.gz

RUN mkdir -p /module
WORKDIR /module

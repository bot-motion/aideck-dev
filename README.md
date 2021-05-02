[this is still work in progress]

Development kit for the AI deck
===============================

Developing for the [AI Deck](https://store.bitcraze.io/collections/decks/products/ai-deck-1-1) of the [nano-quadcopter Crazyflie](https://www.bitcraze.io/products/crazyflie-2-1/) 
requires programming three different chips, each requiring its own toolchain, debug setup and SDKs:

* the GAP8 chip by Greenwaves Technologies, using the [GAP8 SDK](https://github.com/GreenWaves-Technologies/gap_sdk) currently at v 3.9.1,
* the NINA-W102 chip by [ESP](https://github.com/espressif/esp-idf) and
* the STM32F405 on the quadcopter itself, using the [ARM toolchain](https://launchpad.net/gcc-arm-embedded/+announcement/22902)

This repo provides

* a dockerfile for each chip to build a self-contained development environment for the respective chip
* example bash scripts how to run and use these docker images
* hints on how to integrate these docker images with VS Code to make debugging a breeze.
* example hook files if you want to use these images in a [Github CI setup](https://docs.github.com/en/actions/learn-github-actions)

Dependencies
------------
You need Docker and a standard Linux machine. This was tested and set up on Ubuntu 20.04.


Creating the docker images
--------------------------
You can fork this repo and set up your own builds on Docker Hub, or you can use the script `create.sh` to build your
own images. If you don't want to build your own, you can [download them from the profile `simatai` on Docker Hub](https://hub.docker.com/u/simatai) using

    docker pull simatai/stm-arm:1.1
    docker pull simatai/espidf:3.3.1
    docker pull simatai/gap8:3.9.1

Getting into a docker image and using the toolchain 
---------------------------------------------------
Use the bash scripts in `bin` to log into a container based on the images. If you want to use chip programmers, make sure to 
update the USB port in the scripts.

Check the respective dockerfile to understand where everything was installed inside the different images. In general, each image contains
the SDK for the chip and an appropriate version of OpenOCD and GDB. The working directory for every image is `/module`.


Installing the autotiler for GAP8
---------------------------------

Open up the container to install the auto tiler
```
docker run --rm -it gapsdk:${GAP_SDK_VERSION} /bin/bash
```

Then in the container write:
```
cd /gap_sdk
source configs/ai_deck.sh
make autotiler
```
This will install the autotiler, which requires you to register your email and get a special URL token to download and install the autotiler.

In a separate terminal on your local machine, commit the changes to the image by first looking up the container ID status:
```
docker ps
```

Copy and past the container ID and replace the <container id> on the line here below, then run it in the separate terminal (also adapt the SDK version if you did before)
```
export GAP_SDK_VERSION=3.8.1
docker commit <container id> gapsdk:${GAP_SDK_VERSION}
```

This will save the install of the autotiler on your image. You can close the container in the other terminal with 'exit'


Setting up VS Code 
------------------

Refer to the [VS Code tutorial on developing inside containers](https://code.visualstudio.com/docs/remote/containers-tutorial)
for general pointers on how to use VS Code with the Docker images set up here.

Setting up Github CI
--------------------



Credits
-------
This work has heavily borrowed from work by the [Bitcraze team](https://github.com/bitcraze). The `stm-arm` image, used for 
programming the STM32F405 chip on the Crazyflie itself, is a modified version of the [build image by Bitcraze](https://github.com/bitcraze/docker-builder) 
-- it includes OpenOCD for STM chips to enable debugging from the docker image.


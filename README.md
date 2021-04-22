[this is still work in progress]

Development kit for the AI deck
===============================

Developing for the [AI Deck](https://store.bitcraze.io/collections/decks/products/ai-deck-1-1) of the Crazyflie 
requires programming three different chips, each requiring its own toolchain, debug setup and SDKs:

* the GAP8 chip by Greenwaves Technologies, using the GAP8 SDK,
* the NINA chip by ESP and
* the STM...F4 on the quadcopter itself, using the ARM toolchain

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
own images. If you don't want to build your own, you can download them from the profile `simatai` on Docker Hub using

    docker pull simatai/stm-arm:1.1
    docker pull simatai/espidf:3.3.1
    docker pull simatai/gap8:3.9.1


Getting into a docker image and using the toolchain 
---------------------------------------------------
Use the bash scripts in `bin` to log into a container based on the images. If you want to use chip programmers, make sure to 
update the USB port in the scripts.


Setting up VS Code 
------------------

Refer to the [VS Code tutorial on developing inside containers](https://code.visualstudio.com/docs/remote/containers-tutorial)
for general pointers on how to use VS Code with the Docker images set up here.


Credits
-------
This work has heavily borrowed from work by the [Bitcraze team](https://github.com/bitcraze). The `stm-arm` image, used for 
programming the main chip on the Crazyflie itself, is a modified version of the [build image by Bitcraze](https://github.com/bitcraze/docker-builder).


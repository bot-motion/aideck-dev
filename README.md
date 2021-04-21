
Development kit for the AI deck
===============================

Developing for the AI Deck of the Crazyflie requires programming three different chips, each 
requiring its own toolchain, debug setup and SDKs.

This repo provides

* a dockerfile for each chip to build a self-contained development environment for the respective chip
* example bash scripts how to run and use these docker images
* hints on how to integrate these docker images with VS Code to make debugging a breeze.

Dependencies
------------
You need Docker and a standard Linux machine. This was tested and set up on Ubuntu 20.04.


Creating the docker images
--------------------------
You can fork this repo and set up your own builds on Docker Hub, or you can use the script `create.sh` to build your
own images.


Getting into a docker image and using the toolchain 
---------------------------------------------------





Setting up VS Code 
------------------

Refer to the [VS Code tutorial on developing inside containers](https://code.visualstudio.com/docs/remote/containers-tutorial)
for general pointers on how to use VS Code with the Docker images set up here.





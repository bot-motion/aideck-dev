
# If you have a docker hub repo of your own, put its name here
export DOCKER_REPO=simatai

# Specify the GAP SDK version you want to use
export GAP_SDK_VERSION=3.9.1
docker build -f gap8/Dockerfile --tag ${DOCKER_REPO}/gapsdk:${GAP_SDK_VERSION} --build-arg GAP_SDK_VERSION .


# Open up the container to install the auto tiler
#
#docker run --rm -it gapsdk:${GAP_SDK_VERSION} /bin/bash
#
#Then in the container write:
#
#cd /gap_sdk
#source configs/ai_deck.sh
#make autotiler

#This will install the autotiler, which requires you to register your email and get a special URL token to download and install the autotiler.

#In a separate terminal on your local machine, commit the changes to the image by first looking up the container ID status:
#
#docker ps
#
#Copy and past the container ID and replace the on the line here below, then run it in the separate terminal (also adapt the SDK version if you did before)
#
#
#export GAP_SDK_VERSION=3.9.1
#docker commit <container id> gapsdk:${GAP_SDK_VERSION}

#This will save the install of the autotiler on your image. You can close the container in the other terminal with 'exit'


export ESP_SDK_VERSION=3.3.1
docker build -f nina/Dockerfile --tag ${DOCKER_REPO}/espidf:${ESP_SDK_VERSION} .


docker build -f stm/Dockerfile --tag ${DOCKER_REPO}/arm-stm:1.1




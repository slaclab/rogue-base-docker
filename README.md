[![Build Status](https://github.com/slaclab/rogue-base-docker/workflows/Rogue%20Base%20Docker%20Deployment/badge.svg)](https://github.com/slaclab/rogue-base-docker/actions?query=workflow%3A%22Rogue+Base+Docker+Deployment%22)

# Base Docker image for Rogue

This Docker image, called *rogue-base*, contains all the packages and tools needed to build Rogue. It is use as a base image to generate the Rogue docker image.

## What does it contains

The docker image is base on ubuntu 18.04 and contains the following system packages :
- cmake
- boost
- python3
- pyqt5
- zmq
- epics base 3.15.5
- other basic system tools.

And the following python packages:
- PyYAML
- Pyro4
- parse
- click
- ipython
- pyzmq
- packaging
- matplotlib
- numpy
- pyepics

## Docker image automatic generation

When a tag is pushed to this github repository, a new Docker image is automatically built and push to its [Dockerhub repository](https://hub.docker.com/r/tidair/rogue-base) using GitHub Actions.

The resulting docker image is tagged with the same git tag string (as returned by `git describe --tags --always`).

## How To Get The Container

To get a specific tagged version of the docker image, first you will need to install docker in you host OS and be logged in. Then you can get a copy by running:

```
docker pull tidair/rogue-base:$TAG
```
Where **$TAG** is the tagged version of the container your want to get.

## Running the container

The image is intended mainly to be use as a base to build other docker images. In order to do so, start the new docker image's Dockerfile with this line:

```
ROM tidair/rogue-base:$TAG
```

A container however can be run as well from this image. For example, you can start the container in the foreground with this command

```
docker run -ti --rm --name rogue-base tidair/rogue-base:$TAG
```

Where **$TAG** is the tagged version of the container your want to run.

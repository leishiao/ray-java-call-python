#!/bin/bash

docker build . -f Dockerfile.ray -t demo-ray:latest --progress=plain

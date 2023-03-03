#!/bin/bash

docker build . -f Dockerfile.dev -t demo-dev:latest --progress=plain

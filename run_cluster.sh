#!/bin/bash

HEAD_IP_ADDRESS=192.168.66.1
HOST_IP_ADDRESS=192.168.67.1
PYTHON_CODE_DIR=$(realpath $(pwd)/python)

java  -Dray.job.code-search-path=${PYTHON_CODE_DIR} \
      -Dray.address=${HEAD_IP_ADDRESS}:8179 \
      -Dray.node-ip=${HOST_IP_ADDRESS} \
      -Dray.worker.mode=DRIVER \
      -jar target/call-python-0.0.1-jar-with-dependencies.jar

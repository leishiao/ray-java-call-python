#!/bin/bash

HOST_IP_ADDRESS=192.168.0.119
PYTHON_CODE_DIR=$(realpath $(pwd)/python)

# -Dray.node-ip=${HOST_IP_ADDRESS}

java  -Dray.job.code-search-path=${PYTHON_CODE_DIR} \
      -Dray.address=${HOST_IP_ADDRESS}:6379 \
      -Dray.worker.mode=DRIVER \
      -jar target/call-python-0.0.1-jar-with-dependencies.jar
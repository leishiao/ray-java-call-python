#!/bin/bash

PYTHON_CODE_DIR=$(realpath $(pwd)/python)

java  -Dray.job.code-search-path=${PYTHON_CODE_DIR} \
      -Dray.worker.mode=DRIVER \
      -jar target/call-python-0.0.1-jar-with-dependencies.jar
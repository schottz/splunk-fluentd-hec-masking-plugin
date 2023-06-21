#! /bin/bash

docker buildx build --push --platform linux/arm64/v8,linux/amd64 --tag schottz/itau-fluentd-masking:1.3.2
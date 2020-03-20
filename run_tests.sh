#!/bin/bash

docker run -v "$(pwd):/plugin" buildkite/plugin-tester

#!/bin/sh

# use privileged mode
set -p

# CHANGE THIS PATH
PHANTOMJS_PATH=/home/jann/software/phantomjs-1.9.1-linux-x86_64/bin/phantomjs

$PHANTOMJS_PATH screenshot_helper.js "$1" | base64 -d | convert - -thumbnail 256x192 -

#!/bin/sh

# use privileged mode
set -p

dir=$(dirname $0)

# CHANGE THIS PATH
PHANTOMJS_PATH=/usr/local/Cellar/phantomjs/1.9.1/bin/phantomjs

$PHANTOMJS_PATH $dir/screenshot_helper.js "$1" | base64 -D | convert - -thumbnail 256x192 -

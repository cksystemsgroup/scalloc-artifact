#!/bin/bash

echo "ubuntu deps..."
echo ""
sudo apt-get install \
  build-essential \
  autotools-dev
echo "ubuntu deps... done"

echo "gyp... "
echo ""

if [[ -d deps/gyp ]]; then
  cd deps/gyp
  git pull
else
  mkdir -p deps/gyp
  git clone https://chromium.googlesource.com/external/gyp deps/gyp
fi

if [ $? -eq 0 ]; then
  echo ""
  echo "gyp... done"
else
  exit $?
fi


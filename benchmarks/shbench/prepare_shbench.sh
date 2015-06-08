#!/bin/bash

rm -rf src
curl -o bench.zip http://www.microquill.com/smartheap/shbench/bench.zip
mkdir -p src
unzip -o bench.zip -d src/
rm bench.zip
touch src/smrtheap.h
cd src
patch -p1 < ../rdtsc.patch

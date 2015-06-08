#!/bin/bash

if [[ $# -ne 3 ]]; then
  echo "usage: passive-false-single.sh <preload> <num threads> <rest of params>"
  echo ""
  echo "wraps a single run of passive-false aka cache-scratch"
  echo ""
  echo "example:"
  echo "  ./run/passive-false-single.sh path/to/allocator.so 1 \"1000 8 1000000\""
  exit 1
fi

BINARY=./benchmarks/hoard/out/Release/cache-scratch
PRELOAD=$1
THREADS=$2
REST=$3

rm -f /tmp/cache-scratch
LD_PRELOAD=$PRELOAD $BINARY $THREADS $REST 2>&1 > /tmp/cache-scratch &
pid=$!

renice -n 19 -p $$ > /dev/null

while true ; do
  while read line; do
    if [[ $line == *"elapsed"* ]]; then
      t=$(echo $line | awk '{print $4}')
      break 2
    fi
  done < /tmp/cache-scratch
done

echo "{ \"threads\": $THREADS , \"time\":  $t  }"

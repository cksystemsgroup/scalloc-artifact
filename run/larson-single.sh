#!/bin/bash

if [[ $# -ne 3 ]]; then
  echo "usage: larson-single.sh <preload> <num threads> <rest of params>"
  echo ""
  echo "wraps a single run of larson with rss sampling"
  echo ""
  echo "example:"
  echo "  ./larson-single.sh path/to/allocator.so 1 \"10 7 8 1000 10000 1\""
  exit 1
fi

BINARY=./benchmarks/hoard/out/Release/larson
PRELOAD=$1
THREADS=$2
REST=$3

rm -f /tmp/larson
LD_PRELOAD=$PRELOAD $BINARY $REST $THREADS 2>&1 > /tmp/larson &
pid=$!

renice -n 19 -p $$ > /dev/null

n=0
rss=0
while true ; do
  rss_sample=$(ps --no-headers -o "rss" $pid)
  (( n += 1 ))
  (( rss += rss_sample ))
  sleep 0.1
  while read line; do
    if [[ $line == *"Throughput"* ]]; then
      ops=$(echo $line | awk '{print $3}')
      break 2
    fi
  done < /tmp/larson
done
(( rss = rss / n ))

echo "{ \"threads\": $THREADS , \"ops\":  $ops , \"rss\": $rss }"

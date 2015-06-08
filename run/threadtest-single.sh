#!/bin/bash

if [[ $# -ne 3 ]]; then
  echo "usage: threadtest-single.sh <preload> <num threads> <rest of params>"
  echo ""
  echo "wraps a single run of threadtest with rss sampling"
  echo ""
  echo "example:"
  echo "  ./threadtest-single.sh path/to/allocator.so 1 \"10000 100000 0 8\""
  exit 1
fi

BINARY=./benchmarks/hoard/out/Release/threadtest
PRELOAD=$1
THREADS=$2
REST=$3

rm /tmp/threadtest
export LD_PRELOAD=$PRELOAD
$BINARY $THREADS $REST > /tmp/threadtest &
export LD_PRELOAD=
pid=$!

renice -n 19 -p $$ > /dev/null

n=0
rss=0
while true ; do
  rss_sample=$(ps --no-headers -o "rss" $pid)
  (( n += 1 ))
  (( rss += rss_sample ))
  sleep 0.05
  while read line; do
    if [[ $line == *"Time elapsed"* ]]; then
      exec_time=$(echo $line | awk '{print $4}')
      break 2
    fi
  done < /tmp/threadtest
done
(( rss = rss / n ))

exec_time=$(echo $line | awk '{print $4}')
echo "{ \"threads\": $THREADS , \"time\":  $exec_time , \"rss\": $rss }"

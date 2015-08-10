#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "usage: scalloc-evaluate-span-pool.sh <allocator name> <preload>"
  echo ""
  echo "averaged a fixed configuration of the threadtest benchmark"
  echo ""
  echo "output directory: data/scalloc-eval-span-pool/"
  echo "parameters:"
  echo "  allocator name: a descriptive short name that results in a filename"
  echo "  preload: the allocator library to preload"
  exit 1
fi

DS=$1
PRELOAD=$2

IFS=' ' read -a FOR_THREADS <<< "$THREADS_ITERATOR"
REPS=$REPETITIONS

CFG="10000 100000 0 32"
PRUNE="yes"
BINARY="./run/threadtest-single.sh"
COMMAND="$BINARY "$PRELOAD" <threads> \"$CFG\""

DATA_DIR=data/span-pool-evaluation
mkdir -p $DATA_DIR
RAW_FILE=$DATA_DIR/$DS-raw.dat
AVG_FILE=$DATA_DIR/$DS.dat

raw_preamble="# $COMMAND
# recorded at: $(date)"

avg_preamble="$raw_preamble
# repetitions: $REPS
# threads, avg(execution time), corrected sample stddev(execution time), avg(rss), corrected sample stddev(rss)"

if [[ "$PRUNE" = "yes" ]]; then
  echo "$raw_preamble" > $RAW_FILE
  echo "$avg_preamble" > $AVG_FILE
fi

for i in "${FOR_THREADS[@]}"; do
  echo "$BINARY \"$PRELOAD\" $i \"$CFG\""
  for r in $(seq 1 $REPS); do
    $BINARY "$PRELOAD" $i "$CFG"
  done | tee -a $RAW_FILE | awk '{idx[NR]=$3; val1[NR]=$6; sum1+=$6; val2[NR]=$9; sum2+=$9} END {
    mean1 = sum1/NR
    mean2 = sum2/NR

    sq_sum = 0
    for(i=1;i<=NR;i++) {
      sq_sum += (val1[i] - mean1)^2
    }
    var = sq_sum/(NR-1)
    stddev1 = sqrt(var)

    sq_sum = 0
    for(i=1;i<=NR;i++) {
      sq_sum += (val2[i] - mean2)^2
    }
    var = sq_sum/(NR-1)
    stddev2 = sqrt(var)

    printf "%d,%f,%f,%f,%f\n", idx[1],mean1,stddev1,mean2,stddev2
  }' | tee -a $AVG_FILE
done


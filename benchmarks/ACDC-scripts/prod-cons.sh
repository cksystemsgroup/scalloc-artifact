#!/bin/bash

# EXPERIMENT SETTINGS

OPTIONS="-a -s 4 -S 9 -d 30 -l 1 -L 5 -t 1000000 -O -T 100 -R 100 -N 50000 -C 5000 -H 1000 -A"
FACTOR1="-n"
FACTOR1_VALUES=$THREADS_ITERATOR
REPS=$REPETITIONS
#if RELATIVE is set to 1, the the response will be divided by the value for x
RELATIVE=1

# OUTPUT SETTINGS
OUTPUT_DIR=$BASE_PATH/data/ACDC/prod-cons


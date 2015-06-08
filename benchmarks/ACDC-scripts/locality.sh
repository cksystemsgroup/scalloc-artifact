#!/bin/bash

# EXPERIMENT SETTINGS
OPTIONS="-a -t 1000000 -d 30 -l 1 -L 10 -s 4 -S 5 -i 1 -w 0 -A -N 2000 -C 2000 -H 4"
FACTOR1="-q"
FACTOR1_VALUES="0 10 20 30 40 50 60 70 80 90 100"

REPS=$REPETITIONS
#if RELATIVE is set to 1, the the response will be divided by the value for x
RELATIVE=0

# OUTPUT SETTINGS
OUTPUT_DIR=$BASE_PATH/data/ACDC/locality


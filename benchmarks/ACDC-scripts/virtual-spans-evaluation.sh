#!/bin/bash

# EXPERIMENT SETTINGS
OPTIONS="-a -d 5 -l 1 -L 1 -n 16 -N 1000 -C 500 -H 100 -A"

FACTOR1="-s"
FACTOR1_VALUES="4 6 8 10 12 14 16 18 20"

FACTOR2="-S"
FACTOR2_EXPRESSION="X + 2" # X will be replaced by factor1's value

FACTOR3="-t"
FACTOR3_EXPRESSION="2^X * 1024" # X will be replaced by factor1's value

REPS=$REPETITIONS
#if RELATIVE is set to 1, the the respoinse will be divided by the value for x
RELATIVE=0

# OUTPUT SETTINGS
OUTPUT_DIR=$BASE_PATH/data/ACDC/virtual-spans-evaluation

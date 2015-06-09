#!/bin/bash
CWD=`pwd`
export ALLOCATORS="scalloc scalloc-no-madvise"

# enable Linux transparent hugepages 
sudo sh -c "echo always > /sys/kernel/mm/transparent_hugepage/enabled"

#Run first 2 experiments
$BASE_PATH/benchmarks/ACDC/scripts/run-acdc.sh $BASE_PATH/benchmarks/ACDC-scripts/virtual-spans-evaluation.sh

#Rename results for first 2 experiments
cd $BASE_PATH/data/ACDC/virtual-spans-evaluation
NAMES="access alloc combined free memcons"
for i in $NAMES; do
    mv scalloc-${i}.dat scalloc-transparent-${i}.dat
    mv scalloc-no-madvise-${i}.dat scalloc-no-madvise-transparent-${i}.dat
done
cd $CWD

# disable Linux transparent hugepages
sudo sh -c "echo never > /sys/kernel/mm/transparent_hugepage/enabled"

#Repeat the 2 experiments with different kernel settings
$BASE_PATH/benchmarks/ACDC/scripts/run-acdc.sh $BASE_PATH/benchmarks/ACDC-scripts/virtual-spans-evaluation.sh

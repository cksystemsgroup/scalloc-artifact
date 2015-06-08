#!/bin/bash

unset BASE_PATH
unset ALLOCATOR_PATH
unset LD_LIBRARY_PATH
unset ACDC
unset ALLOCATORS
unset REPETITIONS
unset THREADS_ITERATOR

if [[ $# -ne 1 ]]; then
  echo "usage: . ./env.sh <fast|paper>"
  echo ""
  echo "previous settings have been wiped"
  return 1
fi

# allow overcommiting memory
sudo sh -c "echo 1 > /proc/sys/vm/overcommit_memory"
# disable transparent hugepages since they prohibit using madvise()
sudo sh -c "echo never > /sys/kernel/mm/transparent_hugepage/enabled"
sudo sh -c "echo never > /sys/kernel/mm/transparent_hugepage/defrag"

# general settings for all configurations
export BASE_PATH=$(pwd)
export ALLOCATOR_PATH=$BASE_PATH/allocators
export LD_LIBRARY_PATH=$ALLOCATOR_PATH/
export ACDC=$BASE_PATH/benchmarks/ACDC/out/Release/acdc

export ALLOCATORS="scalloc llalloc jemalloc hoard tcmalloc ptmalloc2 tbbmalloc_proxy"
# streamflow does not properly work in all experiments

case $1 in
  fast)
    export REPETITIONS=2
    export THREADS_ITERATOR="1 4 8 12"
    ;;
  paper)
    export REPETITIONS=10
    export THREADS_ITERATOR="1 2 4 6 8 10 20 30 39 40"
    ;;
  *)
    echo "unknown configuration"
    return 1
    ;;
esac

echo "configuration selected: $1"
echo "  REPETITIONS: $REPETITIONS"
echo "  THREADS_ITERATOR: $THREADS_ITERATOR"
return 0


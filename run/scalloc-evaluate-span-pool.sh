#!/bin/bash

export ALLOCATORS="scalloc scalloc-sp-1-backend"
IFS=' ' read -a FOR_ALLOCATORS <<< "$ALLOCATORS"

for a in "${FOR_ALLOCATORS[@]}"; do
  ./run/scalloc-evaluate-span-pool-averaged.sh ${a} ${ALLOCATOR_PATH}/lib${a}.so
done

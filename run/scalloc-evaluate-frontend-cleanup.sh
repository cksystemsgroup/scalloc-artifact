#!/bin/bash

export ALLOCATORS="scalloc scalloc-no-cleanup-in-free"
IFS=' ' read -a FOR_ALLOCATORS <<< "$ALLOCATORS"

for a in "${FOR_ALLOCATORS[@]}"; do
  ./run/scalloc-evaluate-frontend-cleanup-averaged.sh ${a} ${ALLOCATOR_PATH}/lib${a}.so
done

#!/bin/bash

IFS=' ' read -a FOR_ALLOCATORS <<< "$ALLOCATORS"

for a in "${FOR_ALLOCATORS[@]}"; do
  if [[ $a == "ptmalloc2" ]]; then
    ./run/passive-false-averaged.sh ${a} ""
  else
    ./run/passive-false-averaged.sh ${a} ${ALLOCATOR_PATH}/lib${a}.so
  fi
done

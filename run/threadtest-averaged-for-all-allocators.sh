#!/bin/bash

IFS=' ' read -a FOR_ALLOCATORS <<< "$ALLOCATORS"

for a in "${FOR_ALLOCATORS[@]}"; do
  if [[ $a == "ptmalloc2" ]]; then
    ./run/threadtest-averaged.sh ${a} ""
  else
    ./run/threadtest-averaged.sh ${a} ${ALLOCATOR_PATH}/lib${a}.so
  fi
done

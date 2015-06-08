#!/bin/bash

CMD="runspec --tune=base --config=[Default configuration file depending on installation] --noreportable --iterations=10 483.xalancbmk"

ALLOCATORS="scalloc jemalloc llalloc hoard tcmalloc streamflow tbbmalloc_proxy"

ALLOCDIR="../allocators/"

echo "ptmalloc2"
$CMD
cp -r result result-after-ptmalloc2

for ALLOCATOR in $ALLOCATORS
do
        echo $ALLOCATOR
        LD_PRELOAD=${ALLOCDIR}lib${ALLOCATOR}.so ${CMD}
        cp -r result result-after-${ALLOCATOR}
done

# The per-allocator data will be located in results-after-[allocator name]

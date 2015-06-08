# shbench

Unfortunately shbench cannot be redistributed (see [LICENSE.shbench](./LICENSE.shbench)) here.

# Retrieving and creating shbench

The following instructions download shbench, patch in support for
measuring system time using rdtsc, and finally build the benchmark.

```bash
./prepare_shbench.sh
../../deps/gyp/gyp --depth=. shbench.gyp
make
BUILDTYPE=Release
```

# Files

* `README.md`: this readmoe file
* `LICENSE.shbench`: the original license
* `shbench.gyp`: gyp build file
* `rdtsc.patch`: patch providing support for measuring time using rdtsc

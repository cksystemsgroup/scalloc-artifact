#!/bin/bash

./run/acdc-locality.sh
./run/acdc-object-size.sh
./run/acdc-prod-cons.sh
./run/threadtest-averaged-for-all-allocators.sh
./run/larson-averaged-for-all-allocators.sh
./run/shbench-averaged-for-all-allocators.sh
./run/active-false-averaged-for-all-allocators.sh
./run/passive-false-averaged-for-all-allocators.sh

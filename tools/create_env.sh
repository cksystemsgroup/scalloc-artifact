#!/bin/bash

BASE_DIR=$(pwd)
GYP=$BASE_DIR/deps/gyp/gyp
BUILD_DIR=$BASE_DIR/build
ALLOCATORS_DIR=$BASE_DIR/allocators
ACDC_DIR=$BASE_DIR/benchmarks/ACDC

mkdir -p $BUILD_DIR

function prepare_acdc {
  ACDC_REPO=https://github.com/cksystemsgroup/ACDC
  if [ -d $ACDC_DIR ]; then
    rm -rf $ACDC_DIR
  fi
  git clone $ACDC_REPO $ACDC_DIR
  cd $ACDC_DIR
  #git checkout v1.3
  $GYP --depth=. acdc.gyp
  BUILDTYPE=Debug make
  BUILDTYPE=Release make
}

function prepare_hoard_benchmarks {
  cd $BASE_DIR/benchmarks/hoard
  $GYP --depth=. hoard.gyp
  BUILDTYPE=Debug make
  BUILDTYPE=Release make
}

function prepare_shbench {
  cd $BASE_DIR/benchmarks/shbench
  ./prepare_shbench.sh
  $GYP --depth=. shbench.gyp
  BUILDTYPE=Debug make
  BUILDTYPE=Release make
}

function prepare_allocators {
  rm -f $ALLOCATORS_DIR
  # depends on prepare_acdc
  cd $ACDC_DIR

  # employ custom builds for scalloc to enable indepth evaluation
  curl -O https://raw.githubusercontent.com/cksystemsgroup/scalloc/master/tools/install_scalloc.sh
  chmod +x install_scalloc.sh
  ./install_allocators.sh jemalloc llalloc tbb hoard streamflow tcmalloc scalloc supermalloc
  ln -s $ACDC_DIR/allocators $ALLOCATORS_DIR
}

prepare_acdc
prepare_hoard_benchmarks
prepare_shbench
prepare_allocators


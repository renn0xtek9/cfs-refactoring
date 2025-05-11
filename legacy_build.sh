#!/bin/bash
set -euxo pipefail

git submodule update --init --recursive

cd current_cfs_repo/cFS/
cp cfe/cmake/Makefile.sample Makefile
cp -r cfe/cmake/sample_defs sample_defs
make distclean
make SIMULATION=native ENABLE_UNIT_TESTS=ON prep DESTDIR=/tmp/legacy_cfs/ 
make -j 20
make install 

#!/bin/bash
set -euxo pipefail
rm -rf build

cmake --preset x86-Debug-generic-linux
cmake --build --preset x86-Debug-generic-linux -- -j 20
ctest --test-dir build
cmake --install build

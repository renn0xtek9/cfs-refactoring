#!/bin/bash
PATH="$PATH:/opt/cmake-4.0.1-linux-x86_64/bin/"
export PATH
set -euxo pipefail
rm -rf build

cmake --preset x86-Debug-generic-linux
cmake --build --preset x86-Debug-generic-linux -- -j 20
cmake --build --preset x86-Debug-generic-linux cmake-dependency-diagrams
ctest --test-dir build
cmake --install build

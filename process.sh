#!/bin/bash
set -euxo pipefail
rm -rf build
cmake --preset x86-Debug
cmake --build --preset x86-Debug -j 20
cmake --install build/build-x86-Debug-make/

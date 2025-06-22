#!/bin/bash
#This script installs all required build dependencies to build and run unit tests of the project.
#This shall be needed by developers and by CI/CD pipelines.

set -euxo pipefail
# shellcheck disable=SC2034
DEBIAN_FRONTEND=noninteractive
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

sudo apt-get update 
sudo apt-get install -y gcc python3 python3-pip clang-format


cd "$DIR"
python3 -m pip install -r requirements.txt

cd /tmp/
wget https://github.com/Kitware/CMake/releases/download/v4.0.1/cmake-4.0.1-linux-x86_64.tar.gz
sudo tar -xf cmake-4.0.1-linux-x86_64.tar.gz -C /opt/

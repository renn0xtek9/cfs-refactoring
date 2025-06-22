#!/bin/bash
#This script installs tools needed for formatting purposes.
#This shall NOT be needed to build the project.

set -euxo pipefail
# shellcheck disable=SC2034
DEBIAN_FRONTEND=noninteractive
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

#!/bin/bash
set -euxo pipefail
# shellcheck disable=SC2034
DEBIAN_FRONTEND=noninteractive
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

"$DIR"/install_build_dependencies.sh
"$DIR"/install_developer_tools.sh
"$DIR"/install_formatting_tools.sh

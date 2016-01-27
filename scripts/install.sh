#!/bin/bash

TEMP_PROJECT_DIR=/tmp/bumper
rm -rf ${TEMP_PROJECT_DIR}
git clone https://github.com/Latyntsev/bumper.git ${TEMP_PROJECT_DIR}
${TEMP_PROJECT_DIR}/scripts/build.sh BAMPER_INSTALL_ROOT="/usr/local"
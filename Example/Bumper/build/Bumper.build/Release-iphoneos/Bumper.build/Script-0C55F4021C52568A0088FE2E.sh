#!/bin/sh
bumper -path ${CODESIGNING_FOLDER_PATH} -text "${APP_VERSION_NUMBER}\\n${ENVIRONMENT_SHORT_NAME} ${CURRENT_PROJECT_VERSION}"

touch ${PROJECT_DIR}/Bumper/Assets.xcassets/AppIcon.appiconset/*

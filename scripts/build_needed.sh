#!/bin/bash

set -e

# We need an absolute path to the dir we're in.
BUMPER_DIR=$(cd "$(dirname "$0")/.."; pwd)

# Will be a short git hash or just '.' if we're not in a git repo.
REVISION=$((\
  git --git-dir="${BUMPER_DIR}/.git" log -n 1 --format=%h 2> /dev/null) || \
  echo ".")

# If we're in a git repo, figure out if any changes have been made to bumper.
if [[ "$REVISION" != "." ]]; then
  NUM_CHANGES=$(\
    (cd "$BUMPER_DIR" && git status --porcelain "$BUMPER_DIR") | wc -l)
  HAS_GIT_CHANGES=$([[ $NUM_CHANGES -gt 0 ]] && echo YES || echo NO)
else
  HAS_GIT_CHANGES=NO
fi

XCODEBUILD_VERSION=$(xcodebuild -version)
XCODEBUILD_VERSION=`expr "$XCODEBUILD_VERSION" : '^.*Build version \(.*\)'`

BUILD_OUTPUT_DIR="$BUMPER_DIR"/build/$REVISION/$XCODEBUILD_VERSION
BUMPER_PATH="$BUILD_OUTPUT_DIR"/Products/Release/bin/bumper

if [[ -e "$BUMPER_PATH" && $REVISION != "." && $HAS_GIT_CHANGES == "NO" && \
      "$1" != "TEST_AFTER_BUILD=YES" ]];
then
  echo 0
else
  echo 1
fi

# vim: set tabstop=2 shiftwidth=2 filetype=sh:

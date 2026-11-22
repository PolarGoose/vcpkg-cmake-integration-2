#!/usr/bin/env bash

set -o xtrace -o errexit -o nounset -o pipefail

currentScriptDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
buildDir="$currentScriptDir/build/$(uname -s)-$(uname -m)"

for testDir in "$currentScriptDir"/test/*; do
  testBuildDir="$buildDir/${testDir##*/}"
  cmake -S "$testDir" -B "$testBuildDir" -G Ninja -DCMAKE_BUILD_TYPE=Release
  cmake --build "$testBuildDir"
done

echo "Success"

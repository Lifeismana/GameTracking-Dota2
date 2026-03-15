#!/bin/bash
set -euo pipefail

cd "${0%/*}"
. ../common.sh

echo "Processing Dota 2..."

set +e
../tools/dump_source2.sh DOTA
DUMPER_EXIT_CODE=$?
set -e

ProcessDepot ".dll"
ProcessDepot ".exe"
DeduplicateStringsFrom ".dll" "game/bin/win64/engine2_strings.txt" "game/bin/win64/tier0_strings.txt" "DumpSource2/.stringsignore"
DeduplicateStringsFrom ".exe" "game/bin/win64/engine2_strings.txt" "game/bin/win64/tier0_strings.txt" "DumpSource2/.stringsignore"
ProcessVPK
ProcessToolAssetInfo

FixUCS2

CreateCommit "$(grep "ClientVersion=" game/dota/steam.inf | grep -o '[0-9\.]*')" "$(grep -o '[0-9\.]*' steam_buildid.txt)"

echo "Done"

exit "$DUMPER_EXIT_CODE"

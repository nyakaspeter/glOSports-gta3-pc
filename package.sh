#!/bin/sh
# Unpack the Docker build (out/re3-port.zip) into out/ports/re3/ and add glos/,
# the driver set from goodluckOS-mali-driver, so the folder is complete for the
# console: copy out/ports/re3/ over /home/player/ports/re3/ (your GTA III game
# files stay there) and out/.local/share/applications/re3.puppy next to the
# other launcher entries.
set -eu
cd "$(dirname "$0")"
GLOS=../goodluckOS-mali-driver/glos
[ -d "$GLOS" ] || { echo "package.sh: $GLOS missing (goodluckOS-mali-driver/assemble-glos.sh)" >&2; exit 1; }
rm -rf out/ports out/.local && unzip -q -o out/re3-port.zip -d out
rm -rf out/ports/re3/glos && mkdir -p out/ports/re3/glos/lib
cp "$GLOS"/glos-gpu "$GLOS"/glos-gpu-switch "$GLOS"/mali.ko "$GLOS"/glos_fbfix.ko out/ports/re3/glos/ && cp "$GLOS"/lib/* out/ports/re3/glos/lib/
ls out/ports/re3 out/ports/re3/glos

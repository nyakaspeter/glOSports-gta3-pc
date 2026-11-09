#!/bin/sh
# Unpack the Docker build (out/re3-port.zip) into out/ports/gta3-pc/ and add glos/,
# the driver set from goodluckOS-mali-driver, so the folder is complete for the
# console: copy out/ports/gta3-pc/ over /home/player/ports/gta3-pc/ (your GTA III game
# files stay there) and out/.local/share/applications/gta3-pc.puppy next to the
# other launcher entries.
set -eu
cd "$(dirname "$0")"
GLOS=../goodluckOS-mali-driver/glos
[ -d "$GLOS" ] || { echo "package.sh: $GLOS missing (goodluckOS-mali-driver/assemble-glos.sh)" >&2; exit 1; }
rm -rf out/ports out/.local && unzip -q -o out/re3-port.zip -d out
rm -rf out/ports/gta3-pc/glos && mkdir -p out/ports/gta3-pc/glos/lib
cp "$GLOS"/glos-gpu "$GLOS"/glos-gpu-switch "$GLOS"/mali.ko "$GLOS"/glos_fbfix.ko out/ports/gta3-pc/glos/ && cp "$GLOS"/lib/* out/ports/gta3-pc/glos/lib/
rm -rf out/ports/gta3-pc/licenses && cp -R licenses out/ports/gta3-pc/licenses
ls out/ports/gta3-pc out/ports/gta3-pc/glos

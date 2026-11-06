#!/bin/sh
# Repeatable GTA III benchmark on the console.
#   tools/bench.sh start          relaunch GTA III with FPS logging + overlay
#   (load your save, don't touch the controls)
#   tools/bench.sh measure [secs] average FPS and main-thread load (default 20 s)
# Turn Vsync and the Frame Limiter off in Display Setup first, or every
# result reads ~30.
set -eu
ROOT=$(cd "$(dirname "$0")/../../goodluckOS-tools" && pwd)
console() { (cd "$ROOT" && GLOS_TIMEOUT=${T:-60} python3 -I console.py "$1"); }

case "${1:-}" in
start)
    console '/usr/local/bin/appctl kill-application; sleep 3; /usr/local/bin/appctl launch-application "env RE3_FPS_COUNTER=1 RE3_FPS_LOG=1 /home/player/ports/re3/start.sh"; sleep 5; pidof re3'
    ;;
measure)
    secs=${2:-20}
    T=$((secs + 30)) console "p=\$(pidof re3); main=\$(cut -d' ' -f14,15 /proc/\$p/task/\$p/stat); n0=\$(wc -l < /dev/shm/re3.log); sleep $secs; main2=\$(cut -d' ' -f14,15 /proc/\$p/task/\$p/stat); echo \$main \$main2 | awk -v s=$secs '{printf \"main thread busy %d%%\\n\", ((\$3+\$4)-(\$1+\$2))/s}'; tail -n +\$((n0 + 1)) /dev/shm/re3.log | grep 'glos: FPS' | awk '{s+=\$3; n++; if(min==\"\"||\$3<min)min=\$3; if(\$3>max)max=\$3} END {if(n) printf \"FPS avg %.1f (min %.1f, max %.1f) over %d samples\\n\", s/n, min, max, n}'"
    ;;
*)
    sed -n 2,8p "$0"
    exit 2
    ;;
esac

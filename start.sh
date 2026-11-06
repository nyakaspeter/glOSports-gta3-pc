#!/bin/sh
# Launch re3 (GTA III) on goodluckOS through glos-gpu, on ARM's closed Mali
# driver (see goodluckOS-mali-driver). Logs to /dev/shm/re3.log.
cd "$(dirname "$0")"
# GTA expects Xbox button positions (A = bottom). goodluckOS maps by the
# Nintendo-style labels, so map the GA36-MB pad by position instead.
export SDL_GAMECONTROLLERCONFIG="1900c621474133362d4d422047616d00,GA36-MB Gamepad,a:b0,b:b1,x:b3,y:b2,back:b8,start:b9,guide:b8,leftshoulder:b4,rightshoulder:b5,lefttrigger:b6,righttrigger:b7,leftstick:b11,rightstick:b12,dpup:b13,dpdown:b14,dpleft:b15,dpright:b16,leftx:a0,lefty:a1,rightx:a2,righty:a3,platform:Linux"

# goodluckOS tuning (see README.md); all off in the binary itself.
export RE3_GL_THREAD=1        # GL command thread on another core
export RE3_PARTICLE_BUDGET=5  # smoke overdraw limit, in screens
export RE3_FAST_PARTICLES=1   # lean particle shader
export RE3_FPS_COUNTER=1      # FPS in the top-left corner
export RE3_RENDER_SCALE=75    # 3D world at 75% (480x360), upscaled
export RE3_STICK_SCALE=1.5     # GA36-MB sticks reach only ~2/3 of the declared range

exec ./glos/glos-gpu run mali ./re3 "$@" >/dev/shm/re3.log 2>&1

# https://github.com/grimfang4/sdl-gpu
# https://github.com/aquawicket/sdl-gpu 
#
# https://github.com/aquawicket/sdl-gpu/archive/refs/heads/master.zip
# https://github.com/grimfang4/sdl-gpu/archive/refs/heads/master.zip


### VERSION ###
DKSET(SDLGPU_VERSION master)
DKSET(SDLGPU_NAME sdl-gpu-${SDLGPU_VERSION})
DKSET(SDLGPU_DL https://github.com/aquawicket/sdl-gpu/archive/refs/heads/${SDLGPU_VERSION}.zip)
DKSET(SDLGPU ${3RDPARTY}/${SDLGPU_NAME})


### INSTALL ###
DKINSTALL(${SDLGPU_DL} sdl-gpu ${SDLGPU})
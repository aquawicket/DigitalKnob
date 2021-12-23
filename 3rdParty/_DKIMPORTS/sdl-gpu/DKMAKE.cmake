# https://github.com/grimfang4/sdl-gpu
# 
# https://github.com/grimfang4/sdl-gpu/archive/refs/heads/master.zip

DKSET(SDLGPU_VERSION master)
DKSET(SDL_GPU_NAME sdl-gpu-${SDLGUP_VERSION})
DKSET(SDLGPU_DL https://github.com/grimfang4/sdl-gpu/archive/refs/heads/master.zip)
DKSET(SDLGPU ${3RDPARTY}/${SDLGPU_NAME})

DKINSTALL(${SDLGPU_DL} sdl-gpu ${SDLGPU})
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


### DKPLUGINS LINK ###
DKINCLUDE(${SDLGPU}/include)
WIN_DEBUG_DKLIB(${SDLGPU}/${OS}/${DEBUG_DIR}/sdl-gpu.lib)
WIN_RELEASE_DKLIB(${SDLGPU}/${OS}/${RELEASE_DIR}/sdl-gpu.lib)
MAC_DEBUG_DKLIB(${SDLGPU}/${OS}/${DEBUG_DIR}/libsdl-gpu.a)
MAC_RELEASE_DKLIB(${SDLGPU}/${OS}/${RELEASE_DIR}/libsdl-gpu.a)
IOS_DEBUG_DKLIB(${SDLGPU}/${OS}/${DEBUG_DIR}/libsdl-gpu.a)
IOS_RELEASE_DKLIB(${SDLGPU}/${OS}/${RELEASE_DIR}/libsdl-gpu.a)
IOSSIM_DEBUG_DKLIB(${SDLGPU}/${OS}/${DEBUG_DIR}/libsdl-gpu.a)
IOSSIM_RELEASE_DKLIB(${SDLGPU}/${OS}/${RELEASE_DIR}/libsdl-gpu.a)
LINUX_DEBUG_DKLIB(${SDLGPU}/${OS}/${DEBUG_DIR}/libsdl-gpu.a)
LINUX_RELEASE_DKLIB(${SDLGPU}/${OS}/${RELEASE_DIR}/libsdl-gpu.a)
RASPBERRY_DEBUG_DKLIB(${SDLGPU}/${OS}/${DEBUG_DIR}/libsdl-gpu.a)
RASPBERRY_RELEASE_DKLIB(${SDLGPU}/${OS}/${RELEASE_DIR}/libsdl-gpu.a)
ANDROID_DEBUG_DKLIB(${SDLGPU}/${OS}/${DEBUG_DIR}/libsdl-gpu.a)
ANDROID_RELEASE_DKLIB(${SDLGPU}/${OS}/${RELEASE_DIR}/libsdl-gpu.a)


### COMPILE ###
DKSETPATH(${SDLGPU}/${BUILD_DIR})
DKQCOMMAND(${DKCMAKE_BUILD} ${SDLGPU})


WIN_VS(${SDLGPU_NAME} sdlgpu.sln sdlgpu)
MAC_XCODE(${SDLGPU_NAME} sdlgpu)
IOS_XCODE(${SDLGPU_NAME} sdlgpu)
IOSSIM_XCODE(${SDLGPU_NAME} sdlgpu)
LINUX_DKQCOMMAND(make sdlgpu)
RASPBERRY_DKQCOMMAND(make sdlgpu)
ANDROID_VS(${SDLGPU_NAME} sdlgpu.sln sdlgpu)
# https://github.com/grimfang4/sdl-gpu.git
# https://github.com/grimfang4/sdl-gpu/issues/77   rmlui with sdl-gpu


### DEPEND ###
dk_depend(sdl)


### IMPORT ###
dk_import(https://github.com/grimfang4/sdl-gpu.git)


### LINK ###
dk_include				(${SDL-GPU}/include)
ANDROID_dk_libDebug		(${SDL-GPU}/${OS}/SDL_gpu-VS/lib/${DEBUG_DIR}/libSDL2_gpu_s.a)
ANDROID_dk_libRelease	(${SDL-GPU}/${OS}/SDL_gpu-VS/lib/${RELEASE_DIR}/libSDL2_gpu_s.a)
IOSSIM_dk_libDebug		(${SDL-GPU}/${OS}/SDL_gpu/lib/${DEBUG_DIR}/libSDL2_gpu_s.a)
IOSSIM_dk_libRelease	(${SDL-GPU}/${OS}/SDL_gpu/lib/${RELEASE_DIR}/libSDL2_gpu_s.a)
IOS_dk_libDebug			(${SDL-GPU}/${OS}/SDL_gpu/lib/${DEBUG_DIR}/libSDL2_gpu_s.a)
IOS_dk_libRelease		(${SDL-GPU}/${OS}/SDL_gpu/lib/${RELEASE_DIR}/libSDL2_gpu_s.a)
LINUX_dk_libDebug		(${SDL-GPU}/${OS}/${DEBUG_DIR}/SDL_gpu/lib/libSDL2_gpu.a)
LINUX_dk_libRelease		(${SDL-GPU}/${OS}/${RELEASE_DIR}/SDL_gpu/lib/libSDL2_gpu.a)
MAC_dk_libDebug			(${SDL-GPU}/${OS}/SDL_gpu/lib/${DEBUG_DIR}/libSDL2_gpu.a)
MAC_dk_libRelease		(${SDL-GPU}/${OS}/SDL_gpu/lib/${RELEASE_DIR}/libSDL2_gpu.a)
RASPBERRY_dk_libDebug	(${SDL-GPU}/${OS}/SDL_gpu/lib/${DEBUG_DIR}/libSDL2_gpu_s.a)
RASPBERRY_dk_libRelease	(${SDL-GPU}/${OS}/SDL_gpu/lib/${RELEASE_DIR}/libSDL2_gpu_s.a)
WIN_dk_libDebug			(${SDL-GPU}/${OS}/SDL_gpu-VS/lib/${DEBUG_DIR}/SDL2_gpu_s.lib)
WIN_dk_libRelease		(${SDL-GPU}/${OS}/SDL_gpu-VS/lib/${RELEASE_DIR}/SDL2_gpu_s.lib)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} 
	${SDL_CMAKE} 
	${SDL-GPU})


### COMPILE ###
dk_build(${SDL-GPU} SDL_gpu)

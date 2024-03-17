# https://github.com/grimfang4/sdl-gpu.git
# https://github.com/grimfang4/sdl-gpu/issues/77   rmlui with sdl-gpu


### DEPEND ###
dk_depend(sdl)


### IMPORT ###
dk_import(https://github.com/grimfang4/sdl-gpu.git)


### LINK ###
dk_include					(${SDL_GPU}/include)
if(MSVC)
	WIN_dk_libDebug			(${SDL_GPU}/${OS}/SDL_gpu-VS/lib/${DEBUG_DIR}/SDL2_gpu_s.lib)
	WIN_dk_libRelease		(${SDL_GPU}/${OS}/SDL_gpu-VS/lib/${RELEASE_DIR}/SDL2_gpu_s.lib)
elseif(ANDROID)
	ANDROID_dk_libDebug		(${SDL_GPU}/${OS}/SDL_gpu-VS/lib/${DEBUG_DIR}/libSDL2_gpu_s.a)
	ANDROID_dk_libRelease	(${SDL_GPU}/${OS}/SDL_gpu-VS/lib/${RELEASE_DIR}/libSDL2_gpu_s.a)
elseif(APPLE)
	IOSSIM_dk_libDebug		(${SDL_GPU}/${OS}/SDL_gpu/lib/${DEBUG_DIR}/libSDL2_gpu_s.a)
	IOSSIM_dk_libRelease	(${SDL_GPU}/${OS}/SDL_gpu/lib/${RELEASE_DIR}/libSDL2_gpu_s.a)
	IOS_dk_libDebug			(${SDL_GPU}/${OS}/SDL_gpu/lib/${DEBUG_DIR}/libSDL2_gpu_s.a)
	IOS_dk_libRelease		(${SDL_GPU}/${OS}/SDL_gpu/lib/${RELEASE_DIR}/libSDL2_gpu_s.a)
	MAC_dk_libDebug			(${SDL_GPU}/${OS}/SDL_gpu/lib/${DEBUG_DIR}/libSDL2_gpu.a)
	MAC_dk_libRelease		(${SDL_GPU}/${OS}/SDL_gpu/lib/${RELEASE_DIR}/libSDL2_gpu.a)
elseif(RASPBERRY)
	RASPBERRY_dk_libDebug	(${SDL_GPU}/${OS}/SDL_gpu/lib/${DEBUG_DIR}/libSDL2_gpu_s.a)
	RASPBERRY_dk_libRelease	(${SDL_GPU}/${OS}/SDL_gpu/lib/${RELEASE_DIR}/libSDL2_gpu_s.a)
else()
	dk_libDebug				(${SDL_GPU}/${OS}/${DEBUG_DIR}/SDL_gpu/lib/libSDL2_gpu.a)
	dk_libRelease			(${SDL_GPU}/${OS}/${RELEASE_DIR}/SDL_gpu/lib/libSDL2_gpu.a)
	dk_libDebug				(${SDL_GPU}/${OS}/${DEBUG_DIR}/SDL_gpu/lib/libSDL2_gpu.a)
	dk_libRelease			(${SDL_GPU}/${OS}/${RELEASE_DIR}/SDL_gpu/lib/libSDL2_gpu.a)
endif*(



### GENERATE ###
dk_configure(${SDL_GPU} ${SDL_CMAKE})


### COMPILE ###
dk_build(${SDL_GPU} SDL_gpu)

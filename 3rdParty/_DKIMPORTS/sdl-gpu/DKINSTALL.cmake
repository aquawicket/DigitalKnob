#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


dk_validate(Target_Config  "dk_Target_Config()")
# https://github.com/grimfang4/sdl-gpu.git
# https://github.com/grimfang4/sdl-gpu/issues/77   rmlui with sdl-gpu


### DEPEND ###
dk_depend(sdl)


### IMPORT ###
#dk_import(https://github.com/grimfang4/sdl-gpu.git)
dk_import(https://github.com/grimfang4/sdl-gpu/archive/refs/heads/master.zip)


### LINK ###
dk_include					(${SDL_GPU_DIR}/include)
if(MSVC)
	Windows_dk_libDebug			(${SDL_GPU_CONFIG_DIR}/SDL_gpu-VS/lib/${Debug_Dir}/SDL2_gpu_s.lib)
	Windows_dk_libRelease		(${SDL_GPU_CONFIG_DIR}/SDL_gpu-VS/lib/${Release_Dir}/SDL2_gpu_s.lib)
elseif(Android)
	ANDROID_dk_libDebug		(${SDL_GPU_CONFIG_DIR}/SDL_gpu-VS/lib/${Debug_Dir}/libSDL2_gpu_s.a)
	ANDROID_dk_libRelease	(${SDL_GPU_CONFIG_DIR}/SDL_gpu-VS/lib/${Release_Dir}/libSDL2_gpu_s.a)
elseif(Apple)
	IOSSIM_dk_libDebug		(${SDL_GPU_CONFIG_DIR}/SDL_gpu/lib/${Debug_Dir}/libSDL2_gpu_s.a)
	IOSSIM_dk_libRelease	(${SDL_GPU_CONFIG_DIR}/SDL_gpu/lib/${Release_Dir}/libSDL2_gpu_s.a)
	IOS_dk_libDebug			(${SDL_GPU_CONFIG_DIR}/SDL_gpu/lib/${Debug_Dir}/libSDL2_gpu_s.a)
	IOS_dk_libRelease		(${SDL_GPU_CONFIG_DIR}/SDL_gpu/lib/${Release_Dir}/libSDL2_gpu_s.a)
	MAC_dk_libDebug			(${SDL_GPU_CONFIG_DIR}/SDL_gpu/lib/${Debug_Dir}/libSDL2_gpu.a)
	MAC_dk_libRelease		(${SDL_GPU_CONFIG_DIR}/SDL_gpu/lib/${Release_Dir}/libSDL2_gpu.a)
elseif(Raspberry)
	RASPBERRY_dk_libDebug	(${SDL_GPU_CONFIG_DIR}/SDL_gpu/lib/${Debug_Dir}/libSDL2_gpu_s.a)
	RASPBERRY_dk_libRelease	(${SDL_GPU_CONFIG_DIR}/SDL_gpu/lib/${Release_Dir}/libSDL2_gpu_s.a)
else()
	dk_libDebug				(${SDL_GPU_CONFIG_DIR}/SDL_gpu/lib/libSDL2_gpu.a)
	dk_libRelease			(${SDL_GPU_CONFIG_DIR}/SDL_gpu/lib/libSDL2_gpu.a)
	dk_libDebug				(${SDL_GPU_CONFIG_DIR}/SDL_gpu/lib/libSDL2_gpu.a)
	dk_libRelease			(${SDL_GPU_CONFIG_DIR}/SDL_gpu/lib/libSDL2_gpu.a)
endif()


### GENERATE ###
dk_configure(${SDL_GPU} ${SDL_CMAKE})


### COMPILE ###
dk_build(${SDL_GPU} SDL_gpu)

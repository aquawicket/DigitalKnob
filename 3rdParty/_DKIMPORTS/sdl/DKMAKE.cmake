include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/libsdl-org/SDL
# https://www.libsdl.org/
# https://www.libsdl.org/release/SDL2-2.0.18.zip
# https://stackoverflow.com/a/57734435/688352		# _libiconv or _iconv undefined symbol on Mac OSX
# https://github.com/libsdl-org/SDL/blob/53141a56b4520489ab64ad0ba2c49fbd1a456901/docs/README-cmake.md


### DEPEND ###
ANDROID_dk_depend(android)
ANDROID_dk_depend(android-build-tools)
ANDROID_dk_depend(android-platform-tools)
ANDROID_dk_depend(libiconv)
ANDROID_dk_depend(opengles)
ANDROID_dk_depend(opensles)
if(IOS OR IOSSIM)
	dk_depend(audio_toolbox)
	dk_depend(av_foundation)
	dk_depend(core_audio)
	dk_depend(core_graphics)
	dk_depend(core_haptics)
	dk_depend(core_motion)
	dk_depend(foundation)
	dk_depend(game_controller)
	dk_depend(metal)
	dk_depend(opengles)
	dk_depend(quartz_core)
	dk_depend(uikit)
	#dk_define(SDL_VIDEO_RENDER_OGL)
endif()
LINUX_dk_depend(dl)
LINUX_dk_depend(libxfixes-dev)
LINUX_dk_depend(opengl)
LINUX_dk_depend(pthread)
MAC_dk_depend(appkit)
MAC_dk_depend(audio_toolbox)
MAC_dk_depend(audiounit)
MAC_dk_depend(carbon)
MAC_dk_depend(cocoa)
MAC_dk_depend(core_audio)
MAC_dk_depend(core_foundation)
MAC_dk_depend(core_haptics)
MAC_dk_depend(core_video)
MAC_dk_depend(force_feedback)
MAC_dk_depend(game_controller)
MAC_dk_depend(iokit)
MAC_dk_depend(libiconv)
MAC_dk_depend(media_player)
MAC_dk_depend(metal)
MAC_dk_depend(opengl)
MAC_dk_depend(quartz_core)
RASPBERRY_dk_depend(opengl)
WIN_dk_depend(imm32)
WIN_dk_depend(opengl)
WIN_dk_depend(setupapi)
WIN_dk_depend(shlwapi)
WIN_dk_depend(version)
WIN_dk_depend(winmm)


### IMPORT ###
#dk_import(https://github.com/libsdl-org/SDL.git BRANCH main) # SDL3
dk_import(https://github.com/libsdl-org/SDL/archive/refs/tags/release-2.26.1.zip)



### LINK ###
dk_include				(${SDL_DIR}/include						SDL2_INCLUDE_DIR)
ANDROID_dk_include		(${ANDROID_NDK}/sources/android/cpufeatures)
ANDROID_dk_include		(${SDL_DIR}/src)
DEBUG_dk_include		(${SDL_DEBUG_DIR}/include)
RELEASE_dk_include		(${SDL_RELEASE_DIR}/include)
RASPBERRY_dk_include	(/opt/vc/lib)

#dk_addTarget(sdl SDL2static)	# TODO
#dk_addTarget(sdl SDL2main)		# TODO

#if(sdl_SDL2static)
if(MSVC)
	WIN_dk_libDebug		(${SDL_DEBUG_DIR}/SDL2-staticd.lib		SDL2_LIBRARY_DEBUG)
	WIN_dk_libRelease	(${SDL_RELEASE_DIR}/SDL2-static.lib		SDL2_LIBRARY_RELEASE)
	DEBUG_dk_set		(SDL2_LIBRARY							${SDL2_LIBRARY_DEBUG})
	RELEASE_dk_set		(SDL2_LIBRARY							${SDL2_LIBRARY_RELEASE})
else()
 if(ANDROID)
	ANDROID_dk_libDebug	(${SDL_DEBUG_DIR}/libSDL2.a				SDL2_LIBRARY_DEBUG)
 else()
	dk_libDebug			(${SDL_DEBUG_DIR}/libSDL2d.a			SDL2_LIBRARY_DEBUG)
 endif()
	dk_libRelease		(${SDL_RELEASE_DIR}/libSDL2.a			SDL2_LIBRARY_RELEASE)
endif()
#endif()

#ANDROID_dk_libDebug(${SDL_DEBUG_DIR}/libhidapi.a)
#ANDROID_dk_libRelease(${SDL_RELEASE_DIR}/libhidapi.a)

#if(SDL_SDL2main)
	#ANDROID_dk_libDebug	(${SDL_DEBUG_DIR}/libSDL2main.a			SDL2MAIN_LIBRARY_DEBUG)
	#ANDROID_dk_libRelease	(${SDL_RELEASE_DIR}/libSDL2main.a		SDL2MAIN_LIBRARY_RELEASE)
	#LINUX_dk_libDebug		(${SDL_DEBUG_DIR}/libSDL2maind.a		SDL2MAIN_LIBRARY_DEBUG)
	#LINUX_dk_libRelease	(${SDL_RELEASE_DIR}/libSDL2main.a		SDL2MAIN_LIBRARY_RELEASE)
	#MAC_dk_libDebug		(${SDL_DEBUG_DIR}/libSDL2maind.a		SDL2MAIN_LIBRARY_DEBUG)
	#MAC_dk_libRelease		(${SDL_RELEASE_DIR}/libSDL2main.a		SDL2MAIN_LIBRARY_RELEASE)
	#RASPBERRY_dk_libDebug	(${SDL_DEBUG_DIR}/libSDL2maind.a		SDL2MAIN_LIBRARY_DEBUG)
	#RASPBERRY_dk_libRelease(${SDL_RELEASE_DIR}/libSDL2main.a		SDL2MAIN_LIBRARY_RELEASE)
	#WIN_dk_libDebug		(${SDL_DEBUG_DIR}/SDL2maind.lib			SDL2MAIN_LIBRARY_DEBUG)
	#WIN_dk_libRelease		(${SDL_RELEASE_DIR}/SDL2main.lib		SDL2MAIN_LIBRARY_RELEASE)
	IOSSIM_dk_libDebug		(${SDL_DEBUG_DIR}/libSDL2maind.a		SDL2MAIN_LIBRARY_DEBUG)
	IOSSIM_dk_libRelease	(${SDL_RELEASE_DIR}/libSDL2main.a		SDL2MAIN_LIBRARY_RELEASE)
	IOS_dk_libDebug			(${SDL_DEBUG_DIR}/libSDL2maind.a		SDL2MAIN_LIBRARY_DEBUG)
	IOS_dk_libRelease		(${SDL_RELEASE_DIR}/libSDL2main.a		SDL2MAIN_LIBRARY_RELEASE)
#endif()


### 3RDPARTY LINK ###
#ANDROID_dk_set(SDL_CMAKE
#	"-DCMAKE_C_FLAGS=-I${SDL2_INCLUDE_DIR}"
#	"-DCMAKE_CXX_FLAGS=-I${SDL2_INCLUDE_DIR}"
#	-DSDL2_DIR=${SDL_DIR}/cmake
#	-DSDL2_INCLUDE_DIR=${SDL2_INCLUDE_DIR}
#	-DSDL2_LIBRARY_TEMP=${SDL2_LIBRARY_DEBUG}
#	-DSDL2_LIBRARY=${SDL2_LIBRARY_DEBUG}
#	-DSDL2_LIBRARY_DEBUG=${SDL2_LIBRARY_DEBUG}
#	-DSDL2_LIBRARY_RELEASE=${SDL2_LIBRARY_RELEASE})
#	

if(MULTI_CONFIG)
	if(MSVC)
		dk_set(SDL_CMAKE
			"-DCMAKE_C_FLAGS=/I${SDL2_INCLUDE_DIR}"
			"-DCMAKE_CXX_FLAGS=/I${SDL2_INCLUDE_DIR}" 
			-DSDL2_DIR=${SDL_CONFIG_DIR}
			-DSDL2_INCLUDE_DIR=${SDL2_INCLUDE_DIR}
			-DSDL2_LIBRARY_TEMP=${SDL2_LIBRARY}
			-DSDL2_LIBRARY=${SDL2_LIBRARY}
			-DSDL2_LIBRARY_DEBUG=${SDL2_LIBRARY_DEBUG}
			-DSDL2_LIBRARY_RELEASE=${SDL2_LIBRARY_RELEASE}
			-DSDL2_MAIN_LIBRARY=${SDL2_LIBRARY})
		dk_set(SDLMAIN_CMAKE
			-DSDL2MAIN_LIBRARY_DEBUG=${SDL2MAIN_LIBRARY_DEBUG}
			-DSDL2MAIN_LIBRARY_RELEASE=${SDL2MAIN_LIBRARY_RELEASE})
	else()
		dk_set(SDL_CMAKE
			"-DCMAKE_C_FLAGS=-I${SDL2_INCLUDE_DIR}"
			"-DCMAKE_CXX_FLAGS=-${SDL2_INCLUDE_DIR}" 
			-DSDL2_DIR=${SDL_CONFIG_DIR}
			-DSDL2_INCLUDE_DIR=${SDL2_INCLUDE_DIR}
			-DSDL2_LIBRARY_TEMP=${SDL2_LIBRARY_RELEASE}
			-DSDL2_LIBRARY=${SDL2_LIBRARY_DEBUG}
			-DSDL2_LIBRARY_DEBUG=${SDL2_LIBRARY_DEBUG}
			-DSDL2_LIBRARY_RELEASE=${SDL2_LIBRARY_RELEASE}
			-DSDL2_MAIN_LIBRARY=${SDL2_LIBRARY_RELEASE})
		dk_set(SDLMAIN_CMAKE
			-DSDL2MAIN_LIBRARY_DEBUG=${SDL2MAIN_LIBRARY_DEBUG}
			-DSDL2MAIN_LIBRARY_RELEASE=${SDL2MAIN_LIBRARY_RELEASE})
	endif()
else()
	DEBUG_dk_set(SDL_CMAKE
		"-DCMAKE_C_FLAGS=-I${SDL2_INCLUDE_DIR}"
		"-DCMAKE_CXX_FLAGS=-I${SDL2_INCLUDE_DIR}"
		"-DCMAKE_EXE_LINKER_FLAGS=${SDL2_LIBRARY_DEBUG}"
		-DSDL2_DIR=${SDL_CONFIG_DIR}
		-DSDL2_INCLUDE_DIR=${SDL2_INCLUDE_DIR}
		-DSDL2_LIBRARY_TEMP=${SDL2_LIBRARY_DEBUG}
		-DSDL2_LIBRARY=${SDL2_LIBRARY_DEBUG}
		-DSDL2_LIBRARY_DEBUG=${SDL2_LIBRARY_DEBUG})
	DEBUG_dk_set(SDLMAIN_CMAKE
		-DSDL2MAIN_LIBRARY=${SDL2MAIN_LIBRARY_DEBUG}
		-DSDL2MAIN_LIBRARY_DEBUG=${SDL2MAIN_LIBRARY_DEBUG})
		
	RELEASE_dk_set(SDL_CMAKE
		"-DCMAKE_C_FLAGS=-I${SDL2_INCLUDE_DIR}"
		"-DCMAKE_CXX_FLAGS=-I${SDL2_INCLUDE_DIR}"
		"-DCMAKE_EXE_LINKER_FLAGS=${SDL2_LIBRARY_RELEASE}"
		-DSDL2_DIR=${SDL_CONFIG_DIR}
		-DSDL2_INCLUDE_DIR=${SDL2_INCLUDE_DIR}
		-DSDL2_LIBRARY_TEMP=${SDL2_LIBRARY_RELEASE}
		-DSDL2_LIBRARY=${SDL2_LIBRARY_RELEASE}
		-DSDL2_LIBRARY_RELEASE=${SDL2_LIBRARY_RELEASE})
	RELEASE_dk_set(SDLMAIN_CMAKE
		-DSDL2MAIN_LIBRARY=${SDL2MAIN_LIBRARY_RELEASE}
		-DSDL2MAIN_LIBRARY_RELEASE=${SDL2MAIN_LIBRARY_RELEASE})
endif()


### GENERATE ###

# Remove some flags for some builds
if(ANDROID OR EMSCRIPTEN OR MAC)
	dk_validate(DKCMAKE_BUILD "dk_load(${DKCMAKE_DIR}/DKBuildFlags.cmake)")
	string(REPLACE "-std=c17" 	""	DKCMAKE_BUILD "${DKCMAKE_BUILD}")
	string(REPLACE "-std=c++1z" "" 	DKCMAKE_BUILD "${DKCMAKE_BUILD}")
	string(REPLACE "  " 		" " DKCMAKE_BUILD "${DKCMAKE_BUILD}")
endif()

ANDROID_ARM32_dk_configure		(${SDL_DIR} -DSDL_SHARED=OFF -DLIBTYPE=STATIC )
ANDROID_ARM64_dk_configure		(${SDL_DIR} -DSDL_SHARED=OFF -DLIBTYPE=STATIC -DHAVE_BUILTIN_ICONV=0 -DHAVE_LIBICONV=0 "-DCMAKE_CXX_FLAGS=-DHAVE_GCC_ATOMICS=1" ${ICONV_CMAKE})
EMSCRIPTEN_dk_configure			(${SDL_DIR})
IOS_dk_configure				(${SDL_DIR} -DSDL_SHARED=OFF -DSDL_OPENGLES=ON -DSDL_METAL=ON -DSDL_JOYSTICK=OFF -DSDL_HAPTIC=OFF -DHAVE_BUILTIN_ICONV=0 -DHAVE_LIBICONV=0)
IOSSIM_dk_configure				(${SDL_DIR} -DSDL_SHARED=OFF -DSDL_OPENGLES=ON -DSDL_METAL=ON -DSDL_JOYSTICK=OFF -DSDL_HAPTIC=OFF -DHAVE_BUILTIN_ICONV=0 -DHAVE_LIBICONV=0)
LINUX_dk_configure				(${SDL_DIR} -DSDL_SHARED=OFF -DVIDEO_OPENGLES=OFF -DVIDEO_OPENGL=ON -DDIRECTX=OFF -DVIDEO_WAYLAND=OFF)
MAC_dk_configure				(${SDL_DIR} -DSDL_SHARED=OFF -DSDL_OPENGL=ON -DSDL_METAL=ON -DHAVE_BUILTIN_ICONV=0 -DHAVE_LIBICONV=0 ${ICONV_CMAKE})
RASPBERRY_dk_configure			(${SDL_DIR} -DSDL_SHARED=OFF -DVIDEO_OPENGLES=ON)
WIN_dk_configure				(${SDL_DIR} -DSDL_SHARED=OFF -DLIBTYPE=STATIC -DSDL_LIBC=ON)



### COMPILE ###
dk_build(${SDL_DIR} SDL2-static)
dk_build(${SDL_DIR} SDL2main)

#if(SDL_SDL2static)
	#dk_build(${SDL} SDL2-static)
#endif()
#if(SDL_SDL2main)
	#dk_build(${SDL} SDL2main)
#endif()

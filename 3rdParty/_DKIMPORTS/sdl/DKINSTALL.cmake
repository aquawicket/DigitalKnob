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


############ sdl ############
# https://github.com/libsdl-org/SDL
# https://www.libsdl.org/
# https://www.libsdl.org/release/SDL2-2.0.18.zip
# https://stackoverflow.com/a/57734435/688352		# _libiconv or _iconv undefined symbol on Mac OSX
# https://github.com/libsdl-org/SDL/blob/53141a56b4520489ab64ad0ba2c49fbd1a456901/docs/README-cmake.md

### DEPEND ###
if(Android)
	dk_depend(android)
	dk_depend(android-build-tools)
	dk_depend(android-platform-tools)
	dk_depend(libiconv)
	dk_depend(opengles)
	dk_depend(opensles)
endif()
if(Ios OR Iossim)
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
if(Linux)
	dk_depend(dl)
	dk_depend(libxfixes-dev)
	dk_depend(opengl)
	dk_depend(pthread)
endif()
if(Mac)
	dk_depend(appkit)
	dk_depend(audio_toolbox)
	dk_depend(audiounit)
	dk_depend(carbon)
	dk_depend(cocoa)
	dk_depend(core_audio)
	dk_depend(core_foundation)
	dk_depend(core_haptics)
	dk_depend(core_video)
	dk_depend(force_feedback)
	dk_depend(game_controller)
	dk_depend(iokit)
	dk_depend(libiconv)
	dk_depend(media_player)
	dk_depend(metal)
	dk_depend(opengl)
	dk_depend(quartz_core)
endif()
if(Raspberry)
	dk_depend(opengl)
endif()
if(Windows)
	dk_depend(imm32)
	dk_depend(opengl)
	dk_depend(setupapi)
	dk_depend(shlwapi)
	dk_depend(version)
	dk_depend(winmm)
endif()

### IMPORT ###
dk_import()

### INCLUDE ###
dk_include		(${sdl}/include								SDL2_INCLUDE_DIR)
dk_include		(${sdl_Build_Dir}/include					SDL2_INCLUDE_DIR2)
if(Android)
	dk_include	(${sdl}/src									SDL2_INCLUDE_DIR3)
	dk_include	(${android-ndk}/sources/android/cpufeatures SDL2_INCLUDE_DIR4)
endif()
if(Raspberry)
	dk_include	(/opt/vc/lib								SDL2_INCLUDE_DIR3)
endif()


#dk_addTarget(sdl SDL2-static)	# TODO
#dk_addTarget(sdl SDL2main)		# TODO
set(sdl_SDL2-static 1)
if(Ios OR Iossim OR Android)
	set(sdl_SDL2main   1)
endif()

########### sdl_SDL2static ##########
if(sdl_SDL2-static)
	if(MSVC)
			dk_libDebug		(${sdl_Debug_Dir}/SDL2-staticd.lib		SDL2_LIBRARY_DEBUG		SDL2_LIBRARY)
			dk_libRelease	(${sdl_Release_Dir}/SDL2-static.lib		SDL2_LIBRARY_RELEASE	SDL2_LIBRARY)
	else()
		if(Android)
			dk_libDebug		(${sdl_Debug_Dir}/libSDL2.a				SDL2_LIBRARY_DEBUG		SDL2_LIBRARY)
		else()
			dk_libDebug		(${sdl_Debug_Dir}/libSDL2d.a			SDL2_LIBRARY_DEBUG		SDL2_LIBRARY)
		endif()
		dk_libRelease		(${sdl_Release_Dir}/libSDL2.a			SDL2_LIBRARY_RELEASE	SDL2_LIBRARY)
	endif()
endif()

#if(Android)
#	dk_libDebug(${sdl_Debug_Dir}/libhidapi.a)
#	dk_libRelease(${sdl_Release_Dir}/libhidapi.a)
#endif()

########### sdl_SDL2main ##########
if(sdl_SDL2main)
	if(MSVC)
		dk_libDebug		(${sdl_Debug_Dir}/SDL2maind.lib		SDL2MAIN_LIBRARY_DEBUG		SDL2MAIN_LIBRARY)
		dk_libRelease	(${sdl_Release_Dir}/SDL2main.lib	SDL2MAIN_LIBRARY_RELEASE	SDL2MAIN_LIBRARY)
	else()
		if(Android)
			dk_libDebug	(${sdl_Debug_Dir}/libSDL2main.a		SDL2MAIN_LIBRARY_DEBUG		SDL2MAIN_LIBRARY)
		else()
			dk_libDebug	(${sdl_Debug_Dir}/libSDL2maind.a	SDL2MAIN_LIBRARY_DEBUG		SDL2MAIN_LIBRARY)
		endif()
		dk_libRelease	(${sdl_Release_Dir}/libSDL2main.a	SDL2MAIN_LIBRARY_RELEASE	SDL2MAIN_LIBRARY)
	endif()
endif()


### 3RDPARTY LINK ###
#if(Android)
#	dk_set(sdl_CMAKE -DSDL2_DIR=${sdl}/cmake)
#endif()

if(MSVC)
	dk_set(sdl_CMAKE
		"-DCMAKE_C_FLAGS=/I${SDL2_INCLUDE_DIR}"
		"-DCMAKE_CXX_FLAGS=/I${SDL2_INCLUDE_DIR}" 
		-DSDL2_DIR=${sdl_Config_Dir}
		-DSDL2_INCLUDE_DIR=${SDL2_INCLUDE_DIR}
		-DSDL2_LIBRARY_TEMP=${SDL2_LIBRARY}
		-DSDL2_LIBRARY=${SDL2_LIBRARY}
		-DSDL2_LIBRARY_DEBUG=${SDL2_LIBRARY_DEBUG}
		-DSDL2_LIBRARY_RELEASE=${SDL2_LIBRARY_RELEASE}
		-DSDL2_MAIN_LIBRARY=${SDL2MAIN_LIBRARY})
else()		
	dk_set(sdl_CMAKE
		"-DCMAKE_C_FLAGS=-I${SDL2_INCLUDE_DIR}"
		"-DCMAKE_CXX_FLAGS=-I${SDL2_INCLUDE_DIR}" 
		-DSDL2_DIR=${sdl_Config_Dir}
		-DSDL2_INCLUDE_DIR=${SDL2_INCLUDE_DIR}
		-DSDL2_LIBRARY_TEMP=${SDL2_LIBRARY}
		-DSDL2_LIBRARY=${SDL2_LIBRARY}
		-DSDL2_LIBRARY_DEBUG=${SDL2_LIBRARY_DEBUG}
		-DSDL2_LIBRARY_RELEASE=${SDL2_LIBRARY_RELEASE})
endif()

if(sdl_SDL2main)	
	dk_set(sdlmain_CMAKE
		-DSDL2MAIN_LIBRARY=${SDL2MAIN_LIBRARY}
		-DSDL2MAIN_LIBRARY_DEBUG=${SDL2MAIN_LIBRARY_DEBUG}
		-DSDL2MAIN_LIBRARY_RELEASE=${SDL2MAIN_LIBRARY_RELEASE})
endif()



### CONFIGURE ###
if(Android OR Emscripten OR Mac)	# Remove some flags for some builds
	dk_validate(DKCMAKE_BUILD "dk_load($ENV{DKCMAKE_DIR}/DKBuildFlags.cmake)")
	string(REPLACE "-std=c17" 	""	DKCMAKE_BUILD "${DKCMAKE_BUILD}")
	string(REPLACE "-std=c++1z" "" 	DKCMAKE_BUILD "${DKCMAKE_BUILD}")
	string(REPLACE "  " 		" " DKCMAKE_BUILD "${DKCMAKE_BUILD}")
endif()

if(Android_Arm32)
	dk_configure		(${sdl} -DSDL_SHARED=OFF -DLIBTYPE=STATIC)
elseif(Android_Arm64)
	dk_configure		(${sdl} -DSDL_SHARED=OFF -DLIBTYPE=STATIC -DHAVE_BUILTIN_ICONV=0 -DHAVE_LIBICONV=0 "-DCMAKE_CXX_FLAGS=-DHAVE_GCC_ATOMICS=1" ${ICONV_CMAKE})
elseif(Emscripten)
	dk_configure		(${sdl})
elseif(IOS OR Iossim)
	dk_configure		(${sdl} -DSDL_SHARED=OFF -DSDL_OPENGLES=ON -DSDL_METAL=ON -DSDL_JOYSTICK=OFF -DSDL_HAPTIC=OFF -DHAVE_BUILTIN_ICONV=0 -DHAVE_LIBICONV=0)
elseif(Linux)
	dk_configure		(${sdl} -DSDL_SHARED=OFF -DVIDEO_OPENGLES=OFF -DVIDEO_OPENGL=ON -DDIRECTX=OFF -DVIDEO_WAYLAND=OFF)
elseif(Mac)
	dk_configure		(${sdl} -DSDL_SHARED=OFF -DSDL_OPENGL=ON -DSDL_METAL=ON -DHAVE_BUILTIN_ICONV=0 -DHAVE_LIBICONV=0 ${ICONV_CMAKE})
elseif(Raspberry)
	dk_configure		(${sdl} -DSDL_SHARED=OFF -DVIDEO_OPENGLES=ON)
elseif(Windows)
	dk_configure		(${sdl} -DSDL_SHARED=OFF -DLIBTYPE=STATIC -DSDL_LIBC=ON)
endif()


### COMPILE ###
if(sdl_SDL2-static)
	dk_build(${sdl} SDL2-static)
endif()
if(sdl_SDL2main)
	dk_build(${sdl} SDL2main)
endif()

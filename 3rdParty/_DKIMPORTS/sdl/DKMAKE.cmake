# https://github.com/libsdl-org/SDL
# https://www.libsdl.org/
# https://www.libsdl.org/release/SDL2-2.0.18.zip
# https://stackoverflow.com/a/57734435/688352		# _libiconv or _iconv undefined symbol on Mac OSX
# https://github.com/libsdl-org/SDL/blob/53141a56b4520489ab64ad0ba2c49fbd1a456901/docs/README-cmake.md


### DEPEND ###
WIN_dk_depend(opengl)
WIN_dk_depend(winmm.lib)
WIN_dk_depend(imm32.lib)
WIN_dk_depend(version.lib)
WIN_dk_depend(setupapi.lib)
MAC_dk_depend(appkit)
MAC_dk_depend(audio_toolbox)
MAC_dk_depend(audiounit)
MAC_dk_depend(carbon)
MAC_dk_depend(cocoa)
MAC_dk_depend(core_audio)
MAC_dk_depend(core_foundation)
MAC_dk_depend(game_controller)
MAC_dk_depend(core_haptics)
MAC_dk_depend(core_video)
MAC_dk_depend(force_feedback)
MAC_dk_depend(iokit)
MAC_dk_depend(libiconv)
MAC_dk_depend(media_player)
MAC_dk_depend(opengl)
MAC_dk_depend(quartz_core)
MAC_dk_depend(metal)
if(IOS OR IOSSIM)
	dk_depend(audio_toolbox)
	dk_depend(av_foundation)
	dk_depend(core_audio)
	dk_depend(core_graphics)
	dk_depend(core_haptics)
	dk_depend(core_motion)
	dk_depend(foundation)
	dk_depend(game_controller)
	dk_depend(quartz_core)
	dk_depend(uikit)
	dk_depend(opengles)
	dk_depend(metal)
	#dk_define(SDL_VIDEO_RENDER_OGL)
endif()
LINUX_dk_depend(opengl)
RASPBERRY_dk_depend(opengl)
ANDROID_dk_depend(opengles)
ANDROID_dk_depend(opensles)
ANDROID_dk_depend(libiconv)


### IMPORT ###
#dk_import(https://github.com/libsdl-org/SDL/archive/refs/tags/release-2.26.0.zip PATCH)
#dk_import(https://github.com/libsdl-org/SDL/archive/refs/tags/release-2.26.1.zip PATCH)
#dk_import(https://github.com/libsdl-org/SDL.git BRANCH SDL2 PATCH)
dk_import(https://github.com/libsdl-org/SDL.git BRANCH main PATCH)


### LINK ###
#ANDROID_dk_define	(GL_GLEXT_PROTOTYPES)
dk_include			(${SDL}/include)
RASPBERRY_dk_include(/opt/vc/lib)
LINUX_dk_include	(${SDL}/${OS}/${RELEASE_DIR}/include)
ANDROID_dk_include	(${ANDROID-NDK}/sources/android/cpufeatures)
ANDROID_dk_include	(${SDL}/src)

#dk_addTarget(sdl SDL3static)	# TODO
#dk_addTarget(sdl SDL3main)		# TODO

#if(sdl_SDL3static)
	WIN_dk_libDebug			(${SDL}/${OS}/${DEBUG_DIR}/SDL3-staticd.lib)
	WIN_dk_libRelease		(${SDL}/${OS}/${RELEASE_DIR}/SDL3-static.lib)
	UNIX_dk_libDebug		(${SDL}/${OS}/${DEBUG_DIR}/libSDL3.a)
	UNIX_dk_libRelease		(${SDL}/${OS}/${RELEASE_DIR}/libSDL3.a)
#endif()

#ANDROID_dk_libDebug(${SDL}/${OS}/${DEBUG_DIR}/libhidapi.a)
#ANDROID_dk_libRelease(${SDL}/${OS}/${RELEASE_DIR}/libhidapi.a)

#if(sdl_SDL3main)
	#WIN_dk_libDebug		(${SDL}/${OS}/${DEBUG_DIR}/SDL3maind.lib)
	#WIN_dk_libRelease		(${SDL}/${OS}/${RELEASE_DIR}/SDL3main.lib)
	#MAC_dk_libDebug		(${SDL}/${OS}/${DEBUG_DIR}/libSDL3maind.a)
	#MAC_dk_libRelease		(${SDL}/${OS}/${RELEASE_DIR}/libSDL3main.a)
	IOS_dk_libDebug			(${SDL}/${OS}/${DEBUG_DIR}/libSDL3maind.a)
	IOS_dk_libRelease		(${SDL}/${OS}/${RELEASE_DIR}/libSDL3main.a)
	IOSSIM_dk_libDebug		(${SDL}/${OS}/Debug-iphonesimulator/libSDL3maind.a)
	IOSSIM_dk_libRelease	(${SDL}/${OS}/Release-iphonesimulator/libSDL3main.a)
	#LINUX_dk_libDebug		(${SDL}/${OS}/${DEBUG_DIR}/libSDL3maind.a)
	#LINUX_dk_libRelease	(${SDL}/${OS}/${RELEASE_DIR}/libSDL3main.a)
	#RASPBERRY_dk_libDebug	(${SDL}/${OS}/${DEBUG_DIR}/libSDL3maind.a)
	#RASPBERRY_dk_libRelease(${SDL}/${OS}/${RELEASE_DIR}/libSDL3main.a)
	#ANDROID_dk_libDebug		(${SDL}/${OS}/${DEBUG_DIR}/libSDL3main.a)
	#ANDROID_dk_libRelease	(${SDL}/${OS}/${RELEASE_DIR}/libSDL3main.a)
#endif()


### 3RDPARTY LINK ###
WIN_dk_set(SDL_CMAKE
	"-DCMAKE_C_FLAGS=/I${SDL}/include"
	"-DCMAKE_CXX_FLAGS=/I${SDL}/include" 
	-DSDL2_DIR=${SDL}
	-DSDL2_INCLUDE_DIR=${SDL}/include
	-DSDL2_LIBRARY_TEMP=${SDL}/${OS}/${RELEASE_DIR}/SDL3.lib
	-DSDL2_LIBRARY=${SDL}/${OS}/${RELEASE_DIR}/SDL3.lib
	-DSDL2_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/SDL3d.lib
	-DSDL2_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/SDL3.lib
	-DSDL2_MAIN_LIBRARY=${SDL}/${OS}/${RELEASE_DIR}/SDL3main.lib)
WIN_dk_set(SDLMAIN_CMAKE
	-DSDL2MAIN_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/SDL3maind.lib
	-DSDL2MAIN_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/SDL3main.lib)
	
MAC_dk_set(SDL_CMAKE
	"-DCMAKE_C_FLAGS=-I${SDL}/include"
	"-DCMAKE_CXX_FLAGS=-I${SDL}/include" 
	-DSDL2_DIR=${SDL}
	-DSDL2_INCLUDE_DIR=${SDL}/include
	-DSDL2_LIBRARY_TEMP=${SDL}/${OS}/${RELEASE_DIR}/libSDL3.a
	-DSDL2_LIBRARY=${SDL}/${OS}/${RELEASE_DIR}/libSDL3.a
	-DSDL2_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/libSDL3d.a
	-DSDL2_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/libSDL3.a)
MAC_dk_set(SDLMAIN_CMAKE
	-DSDL2MAIN_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/libSDL3maind.a
	-DSDL2MAIN_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/libSDL3main.a)
	
IOS_dk_set(SDL_CMAKE
	"-DCMAKE_C_FLAGS=-I${SDL}/include"
	"-DCMAKE_CXX_FLAGS=-I${SDL}/include" 
	-DSDL2_DIR=${SDL}
	-DSDL2_INCLUDE_DIR=${SDL}/include
	-DSDL2_LIBRARY_TEMP=${SDL}/${OS}/${RELEASE_DIR}/libSDL3.a
	-DSDL2_LIBRARY=${SDL}/${OS}/${RELEASE_DIR}/libSDL3.a
	-DSDL2_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/libSDL3d.a
	-DSDL2_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/libSDL3.a)
IOS_dk_set(SDLMAIN_CMAKE
	-DSDL2MAIN_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/libSDL3maind.a
	-DSDL2MAIN_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/libSDL3main.a)
	
IOSSIM_dk_set(SDL_CMAKE
	"-DCMAKE_C_FLAGS=-I${SDL}/include"
	"-DCMAKE_CXX_FLAGS=-I${SDL}/include" 
	-DSDL2_DIR=${SDL}
	-DSDL2_INCLUDE_DIR=${SDL}/include
	-DSDL2_LIBRARY_TEMP=${SDL}/${OS}/Release-iphonesimulator/libSDL3.a
	-DSDL2_LIBRARY=${SDL}/${OS}/Release-iphonesimulator/libSDL3.a
	-DSDL2_LIBRARY_DEBUG=${SDL}/${OS}/Debug-iphonesimulator/libSDL3d.a
	-DSDL2_LIBRARY_RELEASE=${SDL}/${OS}/Release-iphonesimulator/libSDL3.a)
IOSSIM_dk_set(SDLMAIN_CMAKE
	-DSDL2MAIN_LIBRARY_DEBUG=${SDL}/${OS}/Debug-iphonesimulator/libSDL3maind.a
	-DSDL2MAIN_LIBRARY_RELEASE=${SDL}/${OS}/Release-iphonesimulator/libSDL3main.a)
	
LINUX_dk_set(SDL_CMAKE
	"-DCMAKE_C_FLAGS=-I${SDL}/include"
	"-DCMAKE_CXX_FLAGS=-I${SDL}/include" 
	-DSDL2_DIR=${SDL}
	-DSDL2_INCLUDE_DIR=${SDL}/include
	-DSDL2_LIBRARY_TEMP=${SDL}/${OS}/${RELEASE_DIR}/libSDL3.a
	-DSDL2_LIBRARY=${SDL}/${OS}/${RELEASE_DIR}/libSDL3.a
	-DSDL2_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/libSDL3.a
	-DSDL2_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/libSDL3.a)
	
RASPBERRY_dk_set(SDL_CMAKE
	"-DCMAKE_C_FLAGS=-I${SDL}/include"
	"-DCMAKE_CXX_FLAGS=-I${SDL}/include" 
	-DSDL2_INCLUDE_DIR=${SDL}/include
	-DSDL2_LIBRARY_TEMP=${SDL}/${OS}/${RELEASE_DIR}/libSDL3.a
	-DSDL2_LIBRARY=${SDL}/${OS}/${RELEASE_DIR}/libSDL3.a
	-DSDL2_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/libSDL3.a
	-DSDL2_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/libSDL3.a)
	
ANDROID_dk_set(SDL_CMAKE
	"-DCMAKE_C_FLAGS=-I${SDL}/include"
	"-DCMAKE_CXX_FLAGS=-I${SDL}/include" 
	-DSDL2_DIR=${SDL}/cmake
	-DSDL2_INCLUDE_DIR=${SDL}/include
	-DSDL2_LIBRARY_TEMP=${SDL}/${OS}/${RELEASE_DIR}/libSDL3.a
	-DSDL2_LIBRARY=${SDL}/${OS}/${RELEASE_DIR}/libSDL3.a
	-DSDL2_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}libSDL3.a
	-DSDL2_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/libSDL3.a)

EMSCRIPTEN_dk_set(SDL_CMAKE
	"-DCMAKE_C_FLAGS=-I${SDL}/include"
	"-DCMAKE_CXX_FLAGS=-I${SDL}/include" 
	-DSDL2_DIR=${SDL}
	-DSDL2_INCLUDE_DIR=${SDL}/include
	-DSDL2_LIBRARY_TEMP=${SDL}/${OS}/${RELEASE_DIR}/libSDL3.a
	-DSDL2_LIBRARY=${SDL}/${OS}/${RELEASE_DIR}/libSDL3.a
	-DSDL2_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/libSDL3.a
	-DSDL2_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/libSDL3.a)
EMSCRIPTEN_dk_set(SDLMAIN_CMAKE
	-DSDL2MAIN_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/libSDL3maind.a
	-DSDL2MAIN_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/libSDL3main.a)

### GENERATE ###
WIN_dk_queueCommand			(${DKCMAKE_BUILD} -DSDL_SHARED=OFF -DSDL_LIBC=ON ${SDL})

string(REPLACE "-std=c17" "" SDL_BUILD "${DKCMAKE_BUILD}")
string(REPLACE "  " " " SDL_BUILD "${SDL_BUILD}")
MAC_dk_queueCommand			(${SDL_BUILD} -DSDL_SHARED=OFF -DSDL_OPENGL=ON -DSDL_METAL=ON -DHAVE_BUILTIN_ICONV=0 -DHAVE_LIBICONV=0 ${ICONV_CMAKE} ${SDL})

IOS_dk_queueCommand			(${DKCMAKE_BUILD} -DSDL_SHARED=OFF -DSDL_OPENGLES=ON -DSDL_METAL=ON -DSDL_JOYSTICK=OFF -DSDL_HAPTIC=OFF ${SDL})

IOSSIM_dk_queueCommand		(${DKCMAKE_BUILD} -DSDL_SHARED=OFF -DSDL_OPENGLES=ON -DSDL_METAL=ON -DSDL_JOYSTICK=OFF -DSDL_HAPTIC=OFF ${SDL})

LINUX_dk_queueCommand		(${DKCMAKE_BUILD} -DSDL_SHARED=OFF -DVIDEO_OPENGLES=OFF -DVIDEO_OPENGL=ON -DDIRECTX=OFF -DVIDEO_WAYLAND=OFF ${SDL})

RASPBERRY_dk_queueCommand	(${DKCMAKE_BUILD} -DSDL_SHARED=OFF -DVIDEO_OPENGLES=ON ${SDL})

string(REPLACE "-std=c17" "" SDL_BUILD "${DKCMAKE_BUILD}")
string(REPLACE "-std=c++1z" "" SDL_BUILD "${SDL_BUILD}")
string(REPLACE "  " " " SDL_BUILD "${SDL_BUILD}")
ANDROID32_dk_queueCommand	(${SDL_BUILD} -DLIBTYPE=STATIC -DSDL_SHARED=OFF ${SDL}) 
ANDROID64_dk_queueCommand	(${SDL_BUILD} "-DCMAKE_CXX_FLAGS=-DHAVE_GCC_ATOMICS=1" -DLIBTYPE=STATIC -DSDL_SHARED=OFF -DHAVE_BUILTIN_ICONV=0 -DHAVE_LIBICONV=0 ${ICONV_CMAKE} ${SDL})

EMSCRIPTEN_dk_queueCommand	(${DKCMAKE_BUILD} ${SDL})


### COMPILE ###
dk_build(${SDL_FOLDER})

#if(sdl_SDL3static)
	#dk_build(${SDL_FOLDER} SDL3-static)
#endif()
#if(sdl_SDL3main)
	#dk_build(${SDL_FOLDER} SDL3main)
#endif()

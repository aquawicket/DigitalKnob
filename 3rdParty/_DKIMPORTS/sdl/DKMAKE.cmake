# https://github.com/libsdl-org/SDL
# https://www.libsdl.org/
# https://stackoverflow.com/a/57734435/688352
# https://www.libsdl.org/release/SDL2-2.0.16.zip
# https://www.libsdl.org/release/SDL2-2.0.18.zip


WIN_dk_depend(opengl)
WIN_dk_depend(winmm.lib)
WIN_dk_lib(imm32.lib)
WIN_dk_lib(version.lib)
WIN_dk_lib(Setupapi.lib)
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


## TODO: we can set up everything and from this we can extract all of the information needed to import the library
# dk_import(https://github.com/libsdl-org/SDL)
# SDL         = /3rdParty/SDL                                                                             :the library name and the plugin folder it resides in 
# SDL_main    = 18032979d892639ad4e03584a40a4d205cd2f5fd                                                  :the id of the origin head
# SDL_version = 1803297                                                                                   :the first 7 digits of the head id
# SDL_DL      = https://github.com/libsdl-org/SDL/archive/18032979d892639ad4e03584a40a4d205cd2f5fd.zip    :the library  download link 


#dk_import(https://github.com/libsdl-org/SDL.git BRANCH main)
dk_import(https://github.com/libsdl-org/SDL.git BRANCH release-2.24.0)


### DKPLUGINS LINK ###
#ANDROID_dk_define(GL_GLEXT_PROTOTYPES)
dk_include(${SDL}/include)
ANDROID_dk_include(${ANDROID-NDK}/sources/android/cpufeatures)
ANDROID_dk_include(${SDL}/src)
RASPBERRY_dk_include(/opt/vc/lib)
LINUX_dk_include(${SDL}/${OS}/${RELEASE_DIR}/include)

#dk_addTarget(sdl2 SDL2static)
#dk_addTarget(sdl2 SDL2main)

#if(sdl2_SDL2static)
	#WIN_dk_libDebug(${SDL}/${OS}/${DEBUG_DIR}/SDL2d.lib)
	WIN_dk_libDebug(${SDL}/${OS}/${DEBUG_DIR}/SDL2-staticd.lib)
	#WIN_dk_libRelease(${SDL}/${OS}/${RELEASE_DIR}/SDL2.lib)
	WIN_dk_libRelease(${SDL}/${OS}/${RELEASE_DIR}/SDL2-static.lib)
	MAC_dk_libDebug(${SDL}/${OS}/${DEBUG_DIR}/libSDL2d.a)
	MAC_dk_libRelease(${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a)
	IOS_dk_libDebug(${SDL}/${OS}/${DEBUG_DIR}/libSDL2d.a)
	IOS_dk_libRelease(${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a)
	IOSSIM_dk_libDebug(${SDL}/${OS}/${DEBUG_DIR}/libSDL2d.a)
	IOSSIM_dk_libRelease(${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a)
	LINUX_dk_libDebug(${SDL}/${OS}/${DEBUG_DIR}/libSDL2d.a)
	LINUX_dk_libRelease(${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a)
	RASPBERRY_dk_libDebug(${SDL}/${OS}/${DEBUG_DIR}/libSDL2d.a)
	RASPBERRY_dk_libRelease(${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a)
	ANDROID_dk_libDebug(${SDL}/${OS}/${DEBUG_DIR}/libSDL2.a)
	ANDROID_dk_libRelease(${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a)
#endif()

#ANDROID_dk_libDebug(${SDL}/${OS}/${DEBUG_DIR}/libhidapi.a)
#ANDROID_dk_libRelease(${SDL}/${OS}/${RELEASE_DIR}/libhidapi.a)

#if(sdl2_SDL2main)
	#WIN_dk_libDebug(${SDL}/${OS}/${DEBUG_DIR}/SDL2maind.lib)
	#WIN_dk_libRelease(${SDL}/${OS}/${RELEASE_DIR}/SDL2main.lib)
	#MAC_dk_libDebug(${SDL}/${OS}/${DEBUG_DIR}/libSDL2maind.a)
	#MAC_dk_libRelease(${SDL}/${OS}/${RELEASE_DIR}/libSDL2main.a)
	IOS_dk_libDebug(${SDL}/${OS}/${DEBUG_DIR}/libSDL2maind.a)
	IOS_dk_libRelease(${SDL}/${OS}/${RELEASE_DIR}/libSDL2main.a)
	IOSSIM_dk_libDebug(${SDL}/${OS}/${DEBUG_DIR}/libSDL2maind.a)
	IOSSIM_dk_libRelease(${SDL}/${OS}/${RELEASE_DIR}/libSDL2main.a)
	#LINUX_dk_libDebug(${SDL}/${OS}/${DEBUG_DIR}/libSDL2maind.a)
	#LINUX_dk_libRelease(${SDL}/${OS}/${RELEASE_DIR}/libSDL2main.a)
	#RASPBERRY_dk_libDebug(${SDL}/${OS}/${DEBUG_DIR}/libSDL2maind.a)
	#RASPBERRY_dk_libRelease(${SDL}/${OS}/${RELEASE_DIR}/libSDL2main.a)
	#ANDROID_dk_libDebug(${SDL}/${OS}/${DEBUG_DIR}/libSDL2maind.a)
	#ANDROID_dk_libRelease(${SDL}/${OS}/${RELEASE_DIR}/libSDL2main.a)
#endif()


### 3RDPARTY LINK ###
WIN_dk_set(SDL_CMAKE
	-DSDL2_DIR=${SDL}
	-DSDL2_INCLUDE_DIR=${SDL}/include
	-DSDL2_LIBRARY_TEMP=${SDL}/${OS}/${RELEASE_DIR}/SDL2.lib
	-DSDL2_LIBRARY=${SDL}/${OS}/${RELEASE_DIR}/SDL2.lib
	-DSDL2_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/SDL2d.lib
	-DSDL2_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/SDL2.lib
	-DSDL2_MAIN_LIBRARY=${SDL}/${OS}/${RELEASE_DIR}/SDL2main.lib)
	
WIN_dk_set(SDLMAIN_CMAKE
	-DSDL2MAIN_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/SDL2maind.lib
	-DSDL2MAIN_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/SDL2main.lib)
	
APPLE_dk_set(SDL_CMAKE
	-DSDL2_DIR=${SDL}
	-DSDL2_INCLUDE_DIR=${SDL}/include
	-DSDL2_LIBRARY_TEMP=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a
	-DSDL2_LIBRARY=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a
	-DSDL2_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/libSDL2d.a
	-DSDL2_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a)
	
APPLE_dk_set(SDLMAIN_CMAKE
	-DSDL2MAIN_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/libSDL2maind.a
	-DSDL2MAIN_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/libSDL2main.a)
	
LINUX_dk_set(SDL_CMAKE
	-DSDL2_DIR=${SDL}
	-DSDL2_INCLUDE_DIR=${SDL}/include
	-DSDL2_LIBRARY_TEMP=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a
	-DSDL2_LIBRARY=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a
	-DSDL2_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/libSDL2.a
	-DSDL2_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a)
	
RASPBERRY_dk_set(SDL_CMAKE
	"-DCMAKE_C_FLAGS=-I${SDL}/include" 
	-DSDL2_INCLUDE_DIR=${SDL}/include
	-DSDL2_LIBRARY_TEMP=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a
	-DSDL2_LIBRARY=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a
	-DSDL2_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/libSDL2.a
	-DSDL2_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a)
	
ANDROID_dk_set(SDL_CMAKE
	"-DCMAKE_C_FLAGS=-I${SDL}/include" 
	-DSDL2_DIR=${SDL}/cmake
	-DSDL2_INCLUDE_DIR=${SDL}/include
	-DSDL2_LIBRARY_TEMP=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a
	-DSDL2_LIBRARY=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a
	-DSDL2_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}libSDL2.a
	-DSDL2_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a)
	

### COMPILE ###
dk_setPath(${SDL}/${BUILD_DIR})

WIN_dk_queueCommand(${DKCMAKE_BUILD} -DSDL_SHARED=OFF -DSDL_LIBC=ON ${SDL})
#if(sdl2_SDL2static)
	WIN_dk_visualStudio(${SDL_NAME} SDL2-static)
#endif()
#if(sdl2_SDL2main)
	WIN_dk_visualStudio(${SDL_NAME} SDL2main)
#endif()


if(MAC)
	dk_removeSubstring("-std=c17" "${DKCMAKE_BUILD}" DKCMAKE_BUILD)
endif()
MAC_dk_queueCommand(${DKCMAKE_BUILD} -DSDL_SHARED=OFF -DSDL_OPENGL=ON -DSDL_METAL=ON -DHAVE_BUILTIN_ICONV=0 -DHAVE_LIBICONV=0 ${ICONV_CMAKE} ${SDL})
#if(sdl2_SDL2static)
	MAC_dk_xcode(${SDL_NAME} SDL2-static)
#endif()
#if(sdl2_SDL2main)
	MAC_dk_xcode(${SDL_NAME} SDL2main)
#endif()

IOS_dk_queueCommand(${DKCMAKE_BUILD} -DSDL_SHARED=OFF -DSDL_OPENGLES=ON -DSDL_METAL=ON -DSDL_JOYSTICK=OFF -DSDL_HAPTIC=OFF ${SDL})
#if(sdl2_SDL2static)
	IOS_dk_xcode(${SDL_NAME} SDL2-static)
#endif()
#if(sdl2_SDL2main)
	IOS_dk_xcode(${SDL_NAME} SDL2main)
#endif()

IOSSIM_dk_queueCommand(${DKCMAKE_BUILD} -DSDL_SHARED=OFF -DSDL_OPENGLES=ON -DSDL_METAL=ON -DSDL_JOYSTICK=OFF -DSDL_HAPTIC=OFF ${SDL})
#if(sdl2_SDL2static)
	IOSSIM_dk_xcode(${SDL_NAME} SDL2-static)
#endif()
#if(sdl2_SDL2main)
	IOSSIM_dk_xcode(${SDL_NAME} SDL2main)
#endif()

LINUX_dk_queueCommand(${DKCMAKE_BUILD} -DSDL_SHARED=OFF -DVIDEO_OPENGLES=OFF -DVIDEO_OPENGL=ON -DDIRECTX=OFF -DVIDEO_WAYLAND=OFF ${SDL})
#if(sdl2_SDL2static)
	LINUX_dk_queueCommand(make)
#endif()
#if(sdl2_SDL2main)
	#LINUX_dk_queueCommand(make SDL2main)
#endif()


RASPBERRY_dk_queueCommand(${DKCMAKE_BUILD} -DSDL_SHARED=OFF -DVIDEO_OPENGLES=ON ${SDL})
#if(sdl2_SDL2static)
	RASPBERRY_dk_queueCommand(make)
#endif()
#if(sdl2_SDL2main)
	#RASPBERRY_RELEASE_dk_queueCommand(make SDL2main)
#endif()



if(ANDROID)
set(DKCMAKE_BUILD_SDL2 ${DKCMAKE_BUILD})
#dk_removeSubstring("-std=gnu17" "${DKCMAKE_BUILD}" DKCMAKE_BUILD_SDL2)
#dk_removeSubstring("-std=gnu++1z" "${DKCMAKE_BUILD}" DKCMAKE_BUILD_SDL2)
dk_removeSubstring("-std=c17" "${DKCMAKE_BUILD_SDL2}" DKCMAKE_BUILD_SDL2)
dk_removeSubstring("-std=c++1z" "${DKCMAKE_BUILD_SDL2}" DKCMAKE_BUILD_SDL2)
endif()
ANDROID32_dk_queueCommand(${DKCMAKE_BUILD_SDL2} -DLIBTYPE=STATIC -DSDL_SHARED=OFF ${SDL}) 
ANDROID64_dk_queueCommand(${DKCMAKE_BUILD_SDL2} "-DCMAKE_CXX_FLAGS=-DHAVE_GCC_ATOMICS=1" -DLIBTYPE=STATIC -DSDL_SHARED=OFF ${SDL})
ANDROID_dk_visualStudio(${SDL_NAME} SDL2-static)
ANDROID_dk_visualStudio(${SDL_NAME} SDL2main)

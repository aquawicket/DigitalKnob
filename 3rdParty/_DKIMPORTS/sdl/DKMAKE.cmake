# https://github.com/libsdl-org/SDL
# https://github.com/aquawicket/SDL
# https://www.libsdl.org/
# https://stackoverflow.com/a/57734435/688352
# https://github.com/aquawicket/SDL/archive/refs/heads/main.zip
# https://www.libsdl.org/release/SDL2-2.0.16.zip
# https://www.libsdl.org/release/SDL2-2.0.18.zip

### DEPENDS ###
WIN_DKDEPEND(opengl)
WIN_DKDEPEND(winmm.lib)
WIN_DKLIB(imm32.lib)
WIN_DKLIB(version.lib)
WIN_DKLIB(Setupapi.lib)
MAC_DKDEPEND(appkit)
MAC_DKDEPEND(audio_toolbox)
MAC_DKDEPEND(audiounit)
MAC_DKDEPEND(carbon)
MAC_DKDEPEND(cocoa)
MAC_DKDEPEND(core_audio)
MAC_DKDEPEND(core_foundation)
MAC_DKDEPEND(game_controller)
MAC_DKDEPEND(core_haptics)
MAC_DKDEPEND(core_video)
MAC_DKDEPEND(force_feedback)
MAC_DKDEPEND(iokit)
MAC_DKDEPEND(libiconv)
MAC_DKDEPEND(media_player)
MAC_DKDEPEND(opengl)
MAC_DKDEPEND(quartz_core)
MAC_DKDEPEND(metal)
if(IOS OR IOSSIM)
	DKDEPEND(audio_toolbox)
	DKDEPEND(av_foundation)
	DKDEPEND(core_audio)
	DKDEPEND(core_graphics)
	DKDEPEND(core_haptics)
	DKDEPEND(core_motion)
	DKDEPEND(foundation)
	DKDEPEND(game_controller)
	DKDEPEND(quartz_core)
	DKDEPEND(uikit)
	DKDEPEND(opengles)
	DKDEPEND(metal)
	#DKDEFINE(SDL_VIDEO_RENDER_OGL)
endif()
LINUX_DKDEPEND(opengl)
RASPBERRY_DKDEPEND(opengl)
ANDROID_DKDEPEND(opengles)
ANDROID_DKDEPEND(opensles)


## TODO: we can set up everything and from this we can extract all of the information needed to import the library
# IMPORT_GIT(https://github.com/libsdl-org/SDL)
# SDL         = /3rdParty/SDL                                                                             :the library name and the plugin folder it resides in 
# SDL_main    = 18032979d892639ad4e03584a40a4d205cd2f5fd                                                  :the id of the origin head
# SDL_version = 1803297                                                                                   :the first 7 digits of the head id
# SDL_DL      = https://github.com/libsdl-org/SDL/archive/18032979d892639ad4e03584a40a4d205cd2f5fd.zip    :the library  download link 


#DKIMPORT(https://github.com/libsdl-org/SDL)
DKIMPORT(https://github.com/libsdl-org/SDL/archive/d9009388c8924b15f74ec38a26cc62ea42b40110.zip)
#DKIMPORT(https://github.com/libsdl-org/SDL/archive/d9009388c8924b15f74ec38a26cc62ea42b40110.zip)
#DKIMPORT(https://github.com/libsdl-org/SDL/archive/9d86ec85730e98f6f4d7827f4fda806e9c134f0d.zip)
#DKSET(SDL_VERSION 1803297)
#DKSET(SDL_DL https://github.com/libsdl-org/SDL/archive/18032979d892639ad4e03584a40a4d205cd2f5fd.zip)
#DKSET(SDL_NAME SDL2-${SDL_VERSION})
#DKSET(SDL ${3RDPARTY}/${SDL_NAME})
#DKINSTALL(${SDL_DL} sdl ${SDL})


### DKPLUGINS LINK ###
#ANDROID_DKDEFINE(GL_GLEXT_PROTOTYPES)
DKINCLUDE(${SDL}/include)
ANDROID_DKINCLUDE(${ANDROIDNDK}/sources/android/cpufeatures)
ANDROID_DKINCLUDE(${SDL}/src)
RASPBERRY_DKINCLUDE(/opt/vc/lib)
LINUX_DKINCLUDE(${SDL}/${OS}/${RELEASE_DIR}/include)

#dk_addTarget(sdl2 SDL2static)
#dk_addTarget(sdl2 SDL2main)

#if(sdl2_SDL2static)
	WIN_DEBUG_DKLIB(${SDL}/${OS}/${DEBUG_DIR}/SDL2d.lib)
	WIN_RELEASE_DKLIB(${SDL}/${OS}/${RELEASE_DIR}/SDL2.lib)
	MAC_DEBUG_DKLIB(${SDL}/${OS}/${DEBUG_DIR}/libSDL2d.a)
	MAC_RELEASE_DKLIB(${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a)
	IOS_DEBUG_DKLIB(${SDL}/${OS}/${DEBUG_DIR}/libSDL2d.a)
	IOS_RELEASE_DKLIB(${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a)
	IOSSIM_DEBUG_DKLIB(${SDL}/${OS}/${DEBUG_DIR}/libSDL2d.a)
	IOSSIM_RELEASE_DKLIB(${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a)
	LINUX_DEBUG_DKLIB(${SDL}/${OS}/${DEBUG_DIR}/libSDL2d.a)
	LINUX_RELEASE_DKLIB(${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a)
	RASPBERRY_DEBUG_DKLIB(${SDL}/${OS}/${DEBUG_DIR}/libSDL2d.a)
	RASPBERRY_RELEASE_DKLIB(${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a)
	ANDROID_DEBUG_DKLIB(${SDL}/${OS}/${DEBUG_DIR}/libSDL2.a)
	ANDROID_RELEASE_DKLIB(${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a)
#endif()

#ANDROID_DEBUG_DKLIB(${SDL}/${OS}/${DEBUG_DIR}/libhidapi.a)
#ANDROID_RELEASE_DKLIB(${SDL}/${OS}/${RELEASE_DIR}/libhidapi.a)

#if(sdl2_SDL2main)
	#WIN_DEBUG_DKLIB(${SDL}/${OS}/${DEBUG_DIR}/SDL2maind.lib)
	#WIN_RELEASE_DKLIB(${SDL}/${OS}/${RELEASE_DIR}/SDL2main.lib)
	#MAC_DEBUG_DKLIB(${SDL}/${OS}/${DEBUG_DIR}/libSDL2maind.a)
	#MAC_RELEASE_DKLIB(${SDL}/${OS}/${RELEASE_DIR}/libSDL2main.a)
	IOS_DEBUG_DKLIB(${SDL}/${OS}/${DEBUG_DIR}/libSDL2maind.a)
	IOS_RELEASE_DKLIB(${SDL}/${OS}/${RELEASE_DIR}/libSDL2main.a)
	IOSSIM_DEBUG_DKLIB(${SDL}/${OS}/${DEBUG_DIR}/libSDL2maind.a)
	IOSSIM_RELEASE_DKLIB(${SDL}/${OS}/${RELEASE_DIR}/libSDL2main.a)
	#LINUX_DEBUG_DKLIB(${SDL}/${OS}/${DEBUG_DIR}/libSDL2maind.a)
	#LINUX_RELEASE_DKLIB(${SDL}/${OS}/${RELEASE_DIR}/libSDL2main.a)
	#RASPBERRY_DEBUG_DKLIB(${SDL}/${OS}/${DEBUG_DIR}/libSDL2maind.a)
	#RASPBERRY_RELEASE_DKLIB(${SDL}/${OS}/${RELEASE_DIR}/libSDL2main.a)
	#ANDROID_DEBUG_DKLIB(${SDL}/${OS}/${DEBUG_DIR}/libSDL2maind.a)
	#ANDROID_RELEASE_DKLIB(${SDL}/${OS}/${RELEASE_DIR}/libSDL2main.a)
#endif()


### 3RDPARTY LINK ###
WIN_DKSET(SDL_CMAKE
	-DSDL2_DIR=${SDL}
	-DSDL2_INCLUDE_DIR=${SDL}/include
	-DSDL2_LIBRARY_TEMP=${SDL}/${OS}/${RELEASE_DIR}/SDL2.lib
	-DSDL2_LIBRARY=${SDL}/${OS}/${RELEASE_DIR}/SDL2.lib
	-DSDL2_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/SDL2d.lib
	-DSDL2_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/SDL2.lib)
	
WIN_DKSET(SDLMAIN_CMAKE
	-DSDL2MAIN_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/SDL2maind.lib
	-DSDL2MAIN_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/SDL2main.lib)
	
APPLE_DKSET(SDL_CMAKE
	-DSDL2_DIR=${SDL}
	-DSDL2_INCLUDE_DIR=${SDL}/include
	-DSDL2_LIBRARY_TEMP=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a
	-DSDL2_LIBRARY=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a
	-DSDL2_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/libSDL2d.a
	-DSDL2_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a)
	
APPLE_DKSET(SDLMAIN_CMAKE
	-DSDL2MAIN_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/libSDL2maind.a
	-DSDL2MAIN_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/libSDL2main.a)
	
LINUX_DKSET(SDL_CMAKE
	-DSDL2_DIR=${SDL}
	-DSDL2_INCLUDE_DIR=${SDL}/include
	-DSDL2_LIBRARY_TEMP=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a
	-DSDL2_LIBRARY=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a
	-DSDL2_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/libSDL2.a
	-DSDL2_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a)
	
RASPBERRY_DKSET(SDL_CMAKE
	"-DCMAKE_C_FLAGS=-I${SDL}/include" 
	-DSDL2_INCLUDE_DIR=${SDL}/include
	-DSDL2_LIBRARY_TEMP=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a
	-DSDL2_LIBRARY=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a
	-DSDL2_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}/libSDL2.a
	-DSDL2_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a)
	
ANDROID_DKSET(SDL_CMAKE
	"-DCMAKE_C_FLAGS=-I${SDL}/include" 
	-DSDL2_DIR=${SDL}/cmake
	-DSDL2_INCLUDE_DIR=${SDL}/include
	-DSDL2_LIBRARY_TEMP=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a
	-DSDL2_LIBRARY=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a
	-DSDL2_LIBRARY_DEBUG=${SDL}/${OS}/${DEBUG_DIR}libSDL2.a
	-DSDL2_LIBRARY_RELEASE=${SDL}/${OS}/${RELEASE_DIR}/libSDL2.a)
	

### COMPILE ###
DKSETPATH(${SDL}/${BUILD_DIR})

WIN_DKQCOMMAND(${DKCMAKE_BUILD} -DSDL_SHARED=OFF -DSDL_LIBC=ON ${SDL})
#if(sdl2_SDL2static)
	WIN_VS(${SDL_NAME} SDL2.sln SDL2-static)
#endif()
#if(sdl2_SDL2main)
	WIN_VS(${SDL_NAME} SDL2.sln SDL2main)
#endif()


if(MAC)
	dk_RemoveSubstring("-std=c17" "${DKCMAKE_BUILD}" DKCMAKE_BUILD)
endif()
MAC_DKQCOMMAND(${DKCMAKE_BUILD} -DSDL_SHARED=OFF -DSDL_OPENGL=ON -DSDL_METAL=ON -DHAVE_BUILTIN_ICONV=0 -DHAVE_LIBICONV=0 ${ICONV_CMAKE} ${SDL})
#if(sdl2_SDL2static)
	MAC_XCODE(${SDL_NAME} SDL2-static)
#endif()
#if(sdl2_SDL2main)
	MAC_XCODE(${SDL_NAME} SDL2main)
#endif()

IOS_DKQCOMMAND(${DKCMAKE_BUILD} -DSDL_SHARED=OFF -DSDL_OPENGLES=ON -DSDL_METAL=ON -DSDL_JOYSTICK=OFF -DSDL_HAPTIC=OFF ${SDL})
#if(sdl2_SDL2static)
	IOS_XCODE(${SDL_NAME} SDL2-static)
#endif()
#if(sdl2_SDL2main)
	IOS_XCODE(${SDL_NAME} SDL2main)
#endif()

IOSSIM_DKQCOMMAND(${DKCMAKE_BUILD} -DSDL_SHARED=OFF -DSDL_OPENGLES=ON -DSDL_METAL=ON -DSDL_JOYSTICK=OFF -DSDL_HAPTIC=OFF ${SDL})
#if(sdl2_SDL2static)
	IOSSIM_XCODE(${SDL_NAME} SDL2-static)
#endif()
#if(sdl2_SDL2main)
	IOSSIM_XCODE(${SDL_NAME} SDL2main)
#endif()

LINUX_DKQCOMMAND(${DKCMAKE_BUILD} -DSDL_SHARED=OFF -DVIDEO_OPENGLES=OFF -DVIDEO_OPENGL=ON -DDIRECTX=OFF -DVIDEO_WAYLAND=OFF ${SDL})
#if(sdl2_SDL2static)
	LINUX_DKQCOMMAND(make)
#endif()
#if(sdl2_SDL2main)
	#LINUX_DKQCOMMAND(make SDL2main)
#endif()


RASPBERRY_DKQCOMMAND(${DKCMAKE_BUILD} -DSDL_SHARED=OFF -DVIDEO_OPENGLES=ON ${SDL})
#if(sdl2_SDL2static)
	RASPBERRY_DKQCOMMAND(make)
#endif()
#if(sdl2_SDL2main)
	#RASPBERRY_RELEASE_DKQCOMMAND(make SDL2main)
#endif()



if(ANDROID)
set(DKCMAKE_BUILD_SDL2 ${DKCMAKE_BUILD})
#dk_removeSubstring("-std=gnu17" "${DKCMAKE_BUILD}" DKCMAKE_BUILD_SDL2)
#dk_removeSubstring("-std=gnu++1z" "${DKCMAKE_BUILD}" DKCMAKE_BUILD_SDL2)
dk_removeSubstring("-std=c17" "${DKCMAKE_BUILD_SDL2}" DKCMAKE_BUILD_SDL2)
dk_removeSubstring("-std=c++1z" "${DKCMAKE_BUILD_SDL2}" DKCMAKE_BUILD_SDL2)
endif()
ANDROID32_DKQCOMMAND(${DKCMAKE_BUILD_SDL2} -DLIBTYPE=STATIC -DSDL_SHARED=OFF ${SDL}) 
ANDROID64_DKQCOMMAND(${DKCMAKE_BUILD_SDL2} "-DCMAKE_CXX_FLAGS=-DHAVE_GCC_ATOMICS=1" -DLIBTYPE=STATIC -DSDL_SHARED=OFF ${SDL})
ANDROID_VS(${SDL_NAME} SDL2.sln SDL2-static)
ANDROID_VS(${SDL_NAME} SDL2.sln SDL2main)

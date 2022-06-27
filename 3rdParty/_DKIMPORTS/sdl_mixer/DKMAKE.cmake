# https://github.com/libsdl-org/SDL_mixer
# https://www.libsdl.org/projects/SDL_mixer


dk_depend(smpeg2)
dk_depend(ogg)
dk_depend(vorbis)


#dk_set(SDL_MIXER_VERSION 2.0.1)
#dk_set(SDL_MIXER_NAME SDL2_mixer-${SDL_MIXER_VERSION})
#dk_set(SDL_MIXER_DL https://www.libsdl.org/projects/SDL_mixer/release/SDL2_mixer-2.0.1.zip)
#dk_set(SDL_MIXER ${3RDPARTY}/SDL2_mixer-${SDL_MIXER_VERSION})
#dk_install(${SDL_MIXER_DL} ${SDL_MIXER} PATCH)
dk_import(https://www.libsdl.org/projects/SDL_mixer/release/SDL2_mixer-2.0.1.zip PATCH)
#dk_import(https://github.com/libsdl-org/SDL_mixer.git main PATCH)


### DKPLUGINS LINK ###
dk_include(${SDL_MIXER})
WIN_dk_libDebug(${SDL_MIXER}/${OS}/lib/${DEBUG_DIR}/SDL_mixer.lib)
WIN_dk_libRelease(${SDL_MIXER}/${OS}/lib/${RELEASE_DIR}/SDL_mixer.lib)
APPLE_dk_libDebug(${SDL_MIXER}/${OS}/lib/Debug/SDL_mixer.a)
APPLE_dk_libRelease(${SDL_MIXER}/${OS}/lib/Release/SDL_mixer.a)
LINUX_dk_libDebug(${SDL_MIXER}/${OS}/${DEBUG_DIR}/lib/SDL_mixer.a)
LINUX_dk_libRelease(${SDL_MIXER}/${OS}/${RELEASE_DIR}/lib/SDL_mixer.a)
RASPBERRY_dk_libDebug(${SDL_MIXER}/${OS}/${DEBUG_DIR}/lib/SDL_mixer.a)
RASPBERRY_dk_libRelease(${SDL_MIXER}/${OS}/${RELEASE_DIR}/lib/SDL_mixer.a)
ANDROID_dk_libDebug(${SDL_MIXER}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libSDL2_mixer.a)
ANDROID_dk_libRelease(${SDL_MIXER}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libSDL2_mixer.a)


### GENERATE ###
dk_setPath(${SDL_MIXER}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} ${SDL_CMAKE} ${VORBIS_CMAKE} ${OGG_CMAKE} ${SMPEG2_CMAKE} ${SDL_MIXER})


### COMPILE ###
dk_visualStudio(${SDL_MIXER_NAME} SDLMIXER.sln SDLMIXER)
#WIN_dk_visualStudio(${SDL_MIXER_NAME} SDLMIXER.sln SDLMIXER)
dk_xcode(${SDL_MIXER_NAME} SDLMIXER)
#MAC_dk_xcode(${SDL_MIXER_NAME} SDLMIXER)
#IOS_dk_xcode(${SDL_MIXER_NAME} SDLMIXER)
#IOSSIM_dk_xcode(${SDL_MIXER_NAME} SDLMIXER)
LINUX_dk_queueCommand(make SDLMIXER)
RASPBERRY_dk_queueCommand(make SDLMIXER)
#ANDROID_dk_visualStudio(${SDL_MIXER_NAME} SDLMIXER.sln SDLMIXER)

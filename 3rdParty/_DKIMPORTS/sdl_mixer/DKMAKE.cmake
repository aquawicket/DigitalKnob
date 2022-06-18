# https://github.com/libsdl-org/SDL_mixer
# https://www.libsdl.org/projects/SDL_mixer

### DEPENDS ###
dk_depend(smpeg2)
dk_depend(ogg)
dk_depend(vorbis)



#dk_import(https://github.com/libsdl-org/SDL_mixer.git main PATCH)
#dk_import(https://github.com/libsdl-org/SDL_mixer PATCH)

dk_import(https://www.libsdl.org/projects/SDL_mixer/release/SDL2_mixer-2.0.1.zip PATCH)

#dk_set(SDL_MIXER_VERSION 2.0.1)
#dk_set(SDL_MIXER_NAME SDL2_mixer-${SDL_MIXER_VERSION})
#dk_set(SDL_MIXER_DL https://www.libsdl.org/projects/SDL_mixer/release/SDL2_mixer-2.0.1.zip)
#dk_set(SDL_MIXER ${3RDPARTY}/SDL2_mixer-${SDL_MIXER_VERSION})
#dk_install(${SDL_MIXER_DL} sdl_mixer ${SDL_MIXER} PATCH)



### DKPLUGINS LINK ###
dk_include(${SDL_MIXER})
WIN_DEBUG_DKLIB(${SDL_MIXER}/${OS}/lib/${DEBUG_DIR}/SDL_mixer.lib)
WIN_RELEASE_DKLIB(${SDL_MIXER}/${OS}/lib/${RELEASE_DIR}/SDL_mixer.lib)
APPLE_DEBUG_DKLIB(${SDL_MIXER}/${OS}/lib/Debug/SDL_mixer.a)
APPLE_RELEASE_DKLIB(${SDL_MIXER}/${OS}/lib/Release/SDL_mixer.a)
LINUX_DEBUG_DKLIB(${SDL_MIXER}/${OS}/${DEBUG_DIR}/lib/SDL_mixer.a)
LINUX_RELEASE_DKLIB(${SDL_MIXER}/${OS}/${RELEASE_DIR}/lib/SDL_mixer.a)
RASPBERRY_DEBUG_DKLIB(${SDL_MIXER}/${OS}/${DEBUG_DIR}/lib/SDL_mixer.a)
RASPBERRY_RELEASE_DKLIB(${SDL_MIXER}/${OS}/${RELEASE_DIR}/lib/SDL_mixer.a)
ANDROID_DEBUG_DKLIB(${SDL_MIXER}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libSDL2_mixer.a)
ANDROID_RELEASE_DKLIB(${SDL_MIXER}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libSDL2_mixer.a)



### COMPILE ###
dk_setPath(${SDL_MIXER}/${BUILD_DIR})
DKQCOMMAND(${DKCMAKE_BUILD} ${SDL_CMAKE} ${VORBIS_CMAKE} ${OGG_CMAKE} ${SMPEG2_CMAKE} ${SDL_MIXER})


VS(${SDL_MIXER_NAME} SDLMIXER.sln SDLMIXER)
#WIN_VS(${SDL_MIXER_NAME} SDLMIXER.sln SDLMIXER)
XCODE(${SDL_MIXER_NAME} SDLMIXER)
#MAC_XCODE(${SDL_MIXER_NAME} SDLMIXER)
#IOS_XCODE(${SDL_MIXER_NAME} SDLMIXER)
#IOSSIM_XCODE(${SDL_MIXER_NAME} SDLMIXER)
LINUX_DKQCOMMAND(make SDLMIXER)
RASPBERRY_DKQCOMMAND(make SDLMIXER)
#ANDROID_VS(${SDL_MIXER_NAME} SDLMIXER.sln SDLMIXER)

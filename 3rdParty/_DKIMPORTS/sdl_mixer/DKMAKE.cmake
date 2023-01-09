# https://github.com/libsdl-org/SDL_mixer
# https://www.libsdl.org/projects/SDL_mixer


### DEPEND ###
dk_depend(smpeg2)
dk_depend(ogg)
dk_depend(vorbis)


### IMPORT ###
dk_import(https://github.com/libsdl-org/SDL_mixer/archive/refs/tags/release-2.6.2.zip) # PATCH)
#dk_import(https://github.com/libsdl-org/SDL_mixer.git BRANCH main PATCH) # SDL3


### LINK ###
dk_include				(${SDL_MIXER})
WIN_dk_libDebug			(${SDL_MIXER}/${OS}/lib/${DEBUG_DIR}/SDL_mixer.lib)
WIN_dk_libRelease		(${SDL_MIXER}/${OS}/lib/${RELEASE_DIR}/SDL_mixer.lib)
APPLE_dk_libDebug		(${SDL_MIXER}/${OS}/lib/Debug/SDL_mixer.a)
APPLE_dk_libRelease		(${SDL_MIXER}/${OS}/lib/Release/SDL_mixer.a)
LINUX_dk_libDebug		(${SDL_MIXER}/${OS}/${DEBUG_DIR}/lib/SDL_mixer.a)
LINUX_dk_libRelease		(${SDL_MIXER}/${OS}/${RELEASE_DIR}/lib/SDL_mixer.a)
RASPBERRY_dk_libDebug	(${SDL_MIXER}/${OS}/${DEBUG_DIR}/lib/SDL_mixer.a)
RASPBERRY_dk_libRelease	(${SDL_MIXER}/${OS}/${RELEASE_DIR}/lib/SDL_mixer.a)
ANDROID_dk_libDebug		(${SDL_MIXER}/${OS}/lib/${DEBUG_DIR}/SDL_mixer.a)
ANDROID_dk_libRelease	(${SDL_MIXER}/${OS}/lib/${RELEASE_DIR}/SDL_mixer.a)


### GENERATE ###
dk_queueCommand	(${DKCMAKE_BUILD} ${OGG_CMAKE} ${SDL_CMAKE} ${SMPEG2_CMAKE} ${VORBIS_CMAKE} ${SDL_MIXER})


### COMPILE ###
dk_build(${SDL_MIXER_FOLDER} SDLMIXER)

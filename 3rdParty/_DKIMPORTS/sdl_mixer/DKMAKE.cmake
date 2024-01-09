# https://github.com/libsdl-org/SDL_mixer
# https://www.libsdl.org/projects/SDL_mixer


### DEPEND ###
dk_depend(flac)
dk_depend(ogg)
dk_depend(smpeg2)
dk_depend(vorbis)


### IMPORT ###
dk_import(https://github.com/libsdl-org/SDL_mixer/archive/refs/tags/release-2.6.2.zip) # PATCH)
#dk_import(https://github.com/libsdl-org/SDL_mixer.git BRANCH main PATCH) # SDL3


### LINK ###
dk_include					(${SDL_MIXER}/include)
if(MSVC)
	WIN_dk_libDebug			(${SDL_MIXER}/${OS}/${DEBUG_DIR}/SDL2_mixer-staticd.lib)
	WIN_dk_libRelease		(${SDL_MIXER}/${OS}/${RELEASE_DIR}/SDL2_mixer-static.lib)
elseif(ANDROID)
	ANDROID_dk_libDebug		(${SDL_MIXER}/${OS}/${DEBUG_DIR}/libSDL2_mixer.a)
	ANDROID_dk_libRelease	(${SDL_MIXER}/${OS}/${RELEASE_DIR}/libSDL2_mixer.a)
else()
	dk_libDebug				(${SDL_MIXER}/${OS}/${DEBUG_DIR}/libSDL2_mixerd.a)
	dk_libRelease			(${SDL_MIXER}/${OS}/${RELEASE_DIR}/libSDL2_mixer.a)
endif()


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} 
	-DSDL2MIXER_DEPS_SHARED=OFF 
	-DSDL2MIXER_FLAC=OFF 
	-DSDL2MIXER_MIDI=OFF 
	-DSDL2MIXER_MOD=OFF 
	-DSDL2MIXER_OPUS=OFF 
	-DSDL2MIXER_VENDORED=OFF 
	${FLAC_CMAKE} 
	${OGG_CMAKE} 
	${SDL_CMAKE} 
	${SMPEG2_CMAKE} 
	${VORBIS_CMAKE} 
	${SDL_MIXER})


### COMPILE ###
dk_build(${SDL_MIXER} SDL2_mixer)

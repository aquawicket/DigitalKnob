# https://github.com/libsdl-org/SDL_mixer
# https://www.libsdl.org/projects/SDL_mixer


### DEPEND ###
dk_depend(flac)
dk_depend(ogg)
dk_depend(smpeg2)
dk_depend(vorbis)


### IMPORT ###
#dk_import(https://github.com/libsdl-org/SDL_mixer.git BRANCH main PATCH) # SDL3
dk_import(https://github.com/libsdl-org/SDL_mixer/archive/refs/tags/release-2.6.2.zip) # PATCH)


### LINK ###
dk_include					(${SDL_MIXER}/include										SDL_MIXER_INCLUDE_DIR)
if(MSVC)
	WIN_dk_libDebug			(${SDL_MIXER}/${OS}/${DEBUG_DIR}/SDL2_mixer-staticd.lib		SDL_MIXER_LIBRARY_DEBUG)
	WIN_dk_libRelease		(${SDL_MIXER}/${OS}/${RELEASE_DIR}/SDL2_mixer-static.lib	SDL_MIXER_LIBRARY_RELEASE)
elseif(ANDROID)
	ANDROID_dk_libDebug		(${SDL_MIXER}/${OS}/${DEBUG_DIR}/libSDL2_mixer.a			SDL_MIXER_LIBRARY_DEBUG)
	ANDROID_dk_libRelease	(${SDL_MIXER}/${OS}/${RELEASE_DIR}/libSDL2_mixer.a			SDL_MIXER_LIBRARY_RELEASE)
else()
	dk_libDebug				(${SDL_MIXER}/${OS}/${DEBUG_DIR}/libSDL2_mixerd.a			SDL_MIXER_LIBRARY_DEBUG)
	dk_libRelease			(${SDL_MIXER}/${OS}/${RELEASE_DIR}/libSDL2_mixer.a			SDL_MIXER_LIBRARY_RELEASE)
endif()


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} 
	#-DCMAKE_POSITION_INDEPENDENT_CODE=ON	# "Build static libraries with -fPIC" ON
	#-DSDL2MIXER_CMD=OFF					# "Support an external music player" ${sdl2mixer_cmd_default}
	-DSDL2MIXER_DEPS_SHARED=OFF				# "Default value for loading dependencies dynamically" ON
	-DSDL2MIXER_FLAC=${FLAC} 				# "Enable FLAC music" ON
	-DSDL2MIXER_INSTALL=OFF					# "Enable SDL2mixer install target" ON
	-DSDL2MIXER_MIDI=OFF 					# "Enable MIDI music" ON
	-DSDL2MIXER_MOD=OFF						# "Support loading MOD music" ON
	-DSDL2MIXER_MP3=ON						# "Enable MP3 music" ON
	-DSDL2MIXER_OPUS=OFF 					# "Enable Opus music" ON
	-DSDL2MIXER_SAMPLES=OFF					# "Build the SDL2_mixer sample program(s)" ON
	#-DSDL2MIXER_VENDORED=${MSVC}			# "Use vendored third-party libraries" ${vendored_default}
	-DSDL2MIXER_WAVE=ON						# "Enable streaming WAVE music" ON
	${FLAC_CMAKE} 
	${OGG_CMAKE} 
	${SDL_CMAKE} 
	${SMPEG2_CMAKE} 
	${VORBIS_CMAKE} 
	${SDL_MIXER})


### COMPILE ###
dk_build(${SDL_MIXER} SDL2_mixer)

#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ sdl_mixer ############
# https://github.com/libsdl-org/SDL_mixer
# https://www.libsdl.org/projects/SDL_mixer

dk_load(dk_builder)

### DEPEND ###
dk_depend(flac)
dk_depend(ogg)
dk_depend(opus)
dk_depend(smpeg2)
dk_depend(vorbis)

### IMPORT ###
#dk_import(https://github.com/libsdl-org/SDL_mixer/archive/refs/tags/release-2.6.2.zip PATCH)
dk_import(https://github.com/libsdl-org/SDL_mixer/archive/497f149.zip PATCH)

### LINK ###
dk_include			(${SDL_MIXER_DIR}/include							SDL_MIXER_INCLUDE_DIR)
if(WIN AND MSVC)
	dk_libDebug		(${SDL_MIXER_DEBUG_DIR}/SDL2_mixer-staticd.lib		SDL_MIXER_LIBRARY_DEBUG)
	dk_libRelease	(${SDL_MIXER_RELEASE_DIR}/SDL2_mixer-static.lib		SDL_MIXER_LIBRARY_RELEASE)
elseif(ANDROID)
	dk_libDebug		(${SDL_MIXER_DEBUG_DIR}/libSDL2_mixer.a				SDL_MIXER_LIBRARY_DEBUG)
	dk_libRelease	(${SDL_MIXER_RELEASE_DIR}/libSDL2_mixer.a			SDL_MIXER_LIBRARY_RELEASE)
else()
	dk_libDebug		(${SDL_MIXER_DEBUG_DIR}/libSDL2_mixerd.a			SDL_MIXER_LIBRARY_DEBUG)
	dk_libRelease	(${SDL_MIXER_RELEASE_DIR}/libSDL2_mixer.a			SDL_MIXER_LIBRARY_RELEASE)
endif()


### GENERATE ###
if(MSVC)
	dk_configure(${SDL_MIXER_DIR} 
		-DCMAKE_POSITION_INDEPENDENT_CODE=OFF	# "Build static libraries with -fPIC" ON
		-DSDL2MIXER_CMD=OFF						# "Support an external music player" ${sdl2mixer_cmd_default}
		-DSDL2MIXER_DEPS_SHARED=OFF				# "Default value for loading dependencies dynamically" ON
		-DSDL2MIXER_FLAC=${FLAC} 				# "Enable FLAC music" ON
		-DSDL2MIXER_INSTALL=OFF					# "Enable SDL2mixer install target" ON
		-DSDL2MIXER_MIDI=OFF 					# "Enable MIDI music" ON
		-DSDL2MIXER_MOD=OFF						# "Support loading MOD music" ON
		-DSDL2MIXER_MP3=OFF						# "Enable MP3 music" ON
		-DSDL2MIXER_OPUS=OFF 					# "Enable Opus music" ON
		-DSDL2MIXER_SAMPLES=OFF					# "Build the SDL2_mixer sample program(s)" ON
		-DSDL2MIXER_VENDORED=OFF				# "Use vendored third-party libraries" ${vendored_default}
		-DSDL2MIXER_WAVE=OFF					# "Enable streaming WAVE music" ON
		${FLAC_CMAKE} 
		${OGG_CMAKE} 
		${OPUS_CMAKE}
		${SDL_CMAKE} 
		${SMPEG2_CMAKE}
		${VORBIS_CMAKE})
else()
	dk_configure(${SDL_MIXER_DIR} 
		#-DCMAKE_POSITION_INDEPENDENT_CODE=ON	# "Build static libraries with -fPIC" ON
		-DSDL2MIXER_CMD=OFF						# "Support an external music player" ${sdl2mixer_cmd_default}
		-DSDL2MIXER_DEPS_SHARED=OFF				# "Default value for loading dependencies dynamically" ON
		-DSDL2MIXER_FLAC=${FLAC} 				# "Enable FLAC music" ON
		-DSDL2MIXER_INSTALL=OFF					# "Enable SDL2mixer install target" ON
		-DSDL2MIXER_MIDI=OFF 					# "Enable MIDI music" ON
		-DSDL2MIXER_MOD=OFF						# "Support loading MOD music" ON
		-DSDL2MIXER_MP3=ON						# "Enable MP3 music" ON
		-DSDL2MIXER_OPUS=${OPUS}				# "Enable Opus music" ON
		-DSDL2MIXER_SAMPLES=OFF					# "Build the SDL2_mixer sample program(s)" ON
		-DSDL2MIXER_VENDORED=OFF				# "Use vendored third-party libraries" ${vendored_default}
		-DSDL2MIXER_WAVE=ON						# "Enable streaming WAVE music" ON
		${FLAC_CMAKE} 
		${OGG_CMAKE}
		${OPUS_CMAKE}
		${SDL_CMAKE} 
		${SMPEG2_CMAKE} 
		${VORBIS_CMAKE})
endif()

### COMPILE ###
dk_build(${SDL_MIXER_DIR} SDL2_mixer)

#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


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
dk_depend(wavpack)

### IMPORT ###
#dk_import(https://github.com/libsdl-org/SDL_mixer/archive/refs/tags/release-2.6.2.zip PATCH)
dk_import(https://github.com/libsdl-org/SDL_mixer/archive/a90b86e.zip PATCH) 		# SDL2
#dk_import(https://github.com/libsdl-org/SDL_mixer/archive/497f149.zip PATCH) 		# SDL3

### LINK ###
dk_include			(${SDL_MIXER_DIR}/include							SDL_MIXER_INCLUDE_DIR)
if(Windows AND MSVC)
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
dk_configure(${SDL_MIXER_DIR} 
	-DCMAKE_POSITION_INDEPENDENT_CODE=OFF		# "Build static libraries with -fPIC" ON
	#-DBUILD_SHARED_LIBS=OFF					# "Build the library as a shared library" ON
	-DSDL2MIXER_INSTALL=OFF						# "Enable SDL2mixer install target"
	-DSDL2MIXER_DEPS_SHARED=OFF					# "Default value for loading dependencies dynamically" ON
	-DSDL2MIXER_SAMPLES=OFF						# "Build the SDL2_mixer sample program(s)" ON
	-DSDL2MIXER_CMD=OFF							# "Support an external music player" ${sdl2mixer_cmd_default}
#	-DSDL2MIXER_FLAC=${FLAC}					# "Enable FLAC music" ON
#	-DSDL2MIXER_FLAC_LIBFLAC=${FLAC}			# "Enable FLAC music using libFLAC"
#	-DSDL2MIXER_FLAC_LIBFLAC_SHARED=OFF			# "Dynamically load LIBFLAC" OFF
#	-DSDL2MIXER_FLAC_DRFLAC=OFF					# "Enable FLAC music using drflac"
	-DSDL2MIXER_GME=${GME}						# "Support loading GME music via game-music-emu" OFF
	-DSDL2MIXER_GME_SHARED=OFF					# "Dynamically load libgme" "${SDL2MIXER_DEPS_SHARED}"
	-DSDL2MIXER_MOD=OFF							# "Support loading MOD music" ON
	-DSDL2MIXER_MOD_MODPLUG=OFF					# "Support loading MOD music via modplug" OFF
	-DSDL2MIXER_MOD_MODPLUG_SHARED=OFF			# "Dynamically load modplug" OFF
	-DSDL2MIXER_MOD_XMP=OFF 					# "Support loading MOD music via libxmp" ON SDL2MIXER_MOD OFF
	-DSDL2MIXER_MOD_XMP_LITE=OFF 				# "Use libxmp-lite instead of libxmp" OFF "SDL2MIXER_MOD_XMP;NOT SDL2MIXER_VENDORED" OFF
	-DSDL2MIXER_MOD_XMP_SHARED=OFF 				# "Dynamically load libxmp(-lite)" "${SDL2MIXER_DEPS_SHARED}" SDL2MIXER_MOD_XMP OFF
	-DSDL2MIXER_MP3=OFF 						# "Enable MP3 music" ON
	-DSDL2MIXER_MP3_MINIMP3=OFF 				# "Support loading MP3 music via minimp3" ON SDL2MIXER_MP3 OFF
	-DSDL2MIXER_MP3_MPG123=OFF 					# "Support loading MP3 music via MPG123" OFF SDL2MIXER_MP3 OFF
	-DSDL2MIXER_MP3_MPG123_SHARED=OFF 			# "Dynamically load mpg123" "${SDL2MIXER_DEPS_SHARED}" SDL2MIXER_MP3_MPG123 OFF
	-DSDL2MIXER_MIDI=OFF 						# "Enable MIDI music" ON
	-DSDL2MIXER_MIDI_FLUIDSYNTH=OFF 			# "Support FluidSynth MIDI output" ON "SDL2MIXER_MIDI;NOT SDL2MIXER_VENDORED" OFF
	-DSDL2MIXER_MIDI_FLUIDSYNTH_SHARED=OFF  	# "Dynamically load libfluidsynth" "${SDL2MIXER_DEPS_SHARED}" SDL2MIXER_MIDI_FLUIDSYNTH OFF
	-DSDL2MIXER_MIDI_NATIVE=OFF					# "Support native MIDI output" ON SDL2MIXER_MIDI OFF
	-DSDL2MIXER_MIDI_TIMIDITY=OFF				# "Support timidity MIDI output" ON SDL2MIXER_MIDI OFF
	-DSDL2MIXER_OPUS=${OPUS}					# "Enable Opus music" ON
	-DSDL2MIXER_OPUS_SHARED=OFF					# "Dynamically load libopus" "${SDL2MIXER_DEPS_SHARED}" SDL2MIXER_OPUS OFF
	-DSDL2MIXER_VORBIS_TREMOR_SHARED=OFF 		# "Dynamically load tremor library" "${SDL2MIXER_DEPS_SHARED}" SDL2MIXER_VORBIS_TREMOR OFF
	-DSDL2MIXER_VORBIS_VORBISFILE_SHARED=OFF	# "Dynamically load vorbisfile library" "${SDL2MIXER_DEPS_SHARED}" SDL2MIXER_VORBIS_VORBISFILE OFF
	-DSDL2MIXER_WAVE=${WAVPACK}					# "Enable streaming WAVE music" ON
	-DSDL2MIXER_WAVPACK=${WAVPACK}				# "Enable WavPack music" ON
	-DSDL2MIXER_WAVPACK_DSD=OFF 				# "Enable WavPack DSD music support" OFF SDL2MIXER_WAVPACK OFF
	-DSDL2MIXER_WAVPACK_SHARED=OFF 				# "Dynamically load WavPack library" "${SDL2MIXER_DEPS_SHARED}" SDL2MIXER_WAVPACK OFF
	-DGME_ZLIB=OFF 								# "Enable GME to support compressed sound formats" OFF
	${FLAC_CMAKE}
	${OGG_CMAKE} 
	${OPUS_CMAKE}
	${SDL_CMAKE} 
	${SMPEG2_CMAKE}
	${VORBIS_CMAKE}
	${WAVPACK_CMAKE})


### COMPILE ###
dk_build(${SDL_MIXER_DIR} SDL2_mixer)

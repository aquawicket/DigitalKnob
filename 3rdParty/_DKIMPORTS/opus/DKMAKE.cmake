#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ opus ############
# https://github.com/xiph/opus.git

dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/xiph/opus/archive/7db26934.zip)

### LINK ###
dk_include			(${OPUS}/include					OpusFile_INCLUDE_PATH)
dk_include			(${OPUS}/${triple})
if(MSVC)
	dk_libDebug		(${OPUS_DEBUG_DIR}/opus.lib			OpusFile_LIBRARY_DEBUG)
	dk_libRelease	(${OPUS_RELEASE_DIR}/opus.lib		OpusFile_LIBRARY_RELEASE)
else()
	dk_libDebug		(${OPUS_DEBUG_DIR}/libopus.a		OpusFile_LIBRARY_DEBUG)
	dk_libRelease	(${OPUS_RELEASE_DIR}/libopus.a		OpusFile_LIBRARY_RELEASE)
endif()
if(DEBUG)
	dk_set(OpusFile_LIBRARY ${OpusFile_LIBRARY_DEBUG})
endif()
if(RELEASE)
	dk_set(OpusFile_LIBRARY ${OpusFile_LIBRARY_RELEASE})
endif()

dk_set(OPUS_CMAKE -DOpusFile_INCLUDE_PATH=${OpusFile_INCLUDE_PATH}  -DOpusFile_LIBRARY=${OpusFile_LIBRARY}) 


### GENERATE ###
dk_configure(${OPUS})

### COMPILE ###
dk_build(${OPUS})

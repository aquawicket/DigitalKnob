#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ opus ############
# https://github.com/xiph/opus.git

dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/xiph/opus/archive/7db26934.zip)

### LINK ###
dk_include			(${OPUS}/include					opusfile_INCLUDE_PATH)
dk_include			(${OPUS}/${triple})
if(MSVC)
	dk_libDebug		(${OPUS_DEBUG_DIR}/opus.lib			opusfile_LIBRARY)
	dk_libRelease	(${OPUS_RELEASE_DIR}/opus.lib		opusfile_LIBRARY)
else()
	dk_libDebug		(${OPUS_DEBUG_DIR}/libopus.a		opusfile_LIBRARY)
	dk_libRelease	(${OPUS_RELEASE_DIR}/libopus.a		opusfile_LIBRARY)
endif()

dk_set(OPUS_CMAKE -Dopusfile_INCLUDE_PATH=${opusfile_INCLUDE_PATH}  -Dopusfile_LIBRARY=${opusfile_LIBRARY}) 



### GENERATE ###
dk_configure(${OPUS})

### COMPILE ###
dk_build(${OPUS})

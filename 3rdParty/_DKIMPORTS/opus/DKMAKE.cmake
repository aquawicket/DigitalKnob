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
dk_include			(${OPUS}/include)
dk_include			(${OPUS}/${triple})
if(MSVC)
	dk_libDebug		(${OPUS_DEBUG_DIR}/opus.lib)
	dk_libRelease	(${OPUS_RELEASE_DIR}/opus.lib)
else()
	dk_libDebug		(${OPUS_DEBUG_DIR}/libopus.a)
	dk_libRelease	(${OPUS_RELEASE_DIR}/libopus.a)
endif()

### GENERATE ###
dk_configure(${OPUS})

### COMPILE ###
dk_build(${OPUS})

#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)

# https://github.com/aubio/aubio.git

dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/aubio/aubio/archive/152d6819b360c2e7b379ee3f373d444ab3df0895.zip)
#dk_import(https://github.com/aubio/aubio/archive/refs/heads/master.zip)



### LINK ###
dk_include			(${AUBIO_DIR}/src)
if(WIN AND MSVC)
	dk_libDebug		(${AUBIO_DEBUG_DIR}/aubio.lib)
	dk_libRelease	(${AUBIO_RELEASE_DIR}/aubio.lib)
else()
	dk_libDebug		(${AUBIO_DEBUG_DIR}/libaubio.a)
	dk_libRelease	(${AUBIO_RELEASE_DIR}/libaubio.a)
endif()


### GENERATE ###
dk_configure(${AUBIO_DIR})


### COMPILE ###
dk_build(${AUBIO_DIR})
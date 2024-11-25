#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### aubio ######
# https://github.com/aubio/aubio.git

dk_validate			(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam		(${DKIMPORTS_DIR}/aubio/aubio.txt AUBIO_DL)
dk_import			(${AUBIO_DL})

dk_include			(${AUBIO_DIR}/src)
if(WIN AND MSVC)
	dk_libDebug		(${AUBIO_DEBUG_DIR}/aubio.lib)
	dk_libRelease	(${AUBIO_RELEASE_DIR}/aubio.lib)
else()
	dk_libDebug		(${AUBIO_DEBUG_DIR}/libaubio.a)
	dk_libRelease	(${AUBIO_RELEASE_DIR}/libaubio.a)
endif()

#dk_configure		(${AUBIO_DIR})
dk_build			(${AUBIO_DIR})

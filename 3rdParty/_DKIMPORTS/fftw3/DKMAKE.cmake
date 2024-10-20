#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/FFTW/fftw3.git

### IMPORT ###
dk_validate			(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
dk_getFileParam 	("${DKIMPORTS_DIR}/fftw3/fftw3.txt" FFTW3_DL)
dk_import			(${FFTW3_DL})

### LINK ###
dk_include			(${FFTW3_DIR}/include)
if(MSVC)
	dk_libDebug		(${FFTW3_DEBUG_DIR}/fftw3.lib)
	dk_libRelease	(${FFTW3_RELEASE_DIR}/fftw3.lib)
else()
	dk_libDebug		(${FFTW3_DEBUG_DIR}/libfftw3.a)
	dk_libRelease	(${FFTW3_RELEASE_DIR}/libfftw3.a)
endif()

### GENERATE ###
dk_configure(${FFTW3_DIR})

### COMPILE ###
dk_build(${FFTW3_DIR})# fftw3)

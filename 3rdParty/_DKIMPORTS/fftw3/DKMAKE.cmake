#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://github.com/FFTW/fftw3.git


### IMPORT ###
#dk_import(https://github.com/FFTW/fftw3.git)
dk_import(https://github.com/FFTW/fftw3/archive/refs/heads/master.zip)



### LINK ###
dk_include			(${FFTW3_DIR}/include)
UNIX_dk_libDebug	(${FFTW3_DEBUG_DIR}/libfftw3.a)
UNIX_dk_libRelease	(${FFTW3_RELEASE_DIR}/libfftw3.a)
WIN_dk_libDebug		(${FFTW3_DEBUG_DIR}/fftw3.lib)
WIN_dk_libRelease	(${FFTW3_RELEASE_DIR}/fftw3.lib)


### GENERATE ###
dk_configure(${FFTW3_DIR})


### COMPILE ###
dk_build(${FFTW3_DIR})# fftw3)
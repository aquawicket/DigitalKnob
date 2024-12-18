#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ mpg123 ############
# https://www.mpg123.de

variable_watch(TEST_CURRENT_PLUGIN dk_onVariableWatch)
dk_depend(bash)
dk_depend(autotools)

### IMPORT ###
#dk_import(https://sourceforge.net/projects/mpg123/files/mpg123/1.32.10/mpg123-1.32.10.tar.bz2/download)
dk_import(https://github.com/madebr/mpg123/archive/3c34e2a.zip)


### LINK ###
dk_include			(${MPG123}/include)
if(MSVC)
	dk_libDebug		(${MPG123_DEBUG_DIR}/mpg123.lib)
	dk_libRelease	(${MPG123_RELEASE_DIR}/mpg123.lib)
else()
	dk_libDebug		(${MPG123_DEBUG_DIR}/libmpg123.a)
	dk_libRelease	(${MPG123_RELEASE_DIR}/libmpg123.a)
endif()

dk_queueCommand(${BASH_EXE} -c "${AUTORECONF} -f -i")


### GENERATE ###
dk_configure(${MPG123})


### COMPILE ###
dk_build(${MPG123})
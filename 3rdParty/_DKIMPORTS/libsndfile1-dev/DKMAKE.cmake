#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ libsndfile1-dev ############
dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libsndfile1-dev)
	dk_return()
endif()

### INSTALL ###
if(TINYCORE)
	#dk_command(tce-load -wi libsndfile-dev.tcz)
	dk_installPackage(libsndfile-dev.tcz)
else()
	#dk_depend(sudo)
	#dk_command(${SUDO_EXE} apt -y install libsndfile1-dev)
	dk_installPackage(libsndfile1-dev)
endif()

### LINK ###

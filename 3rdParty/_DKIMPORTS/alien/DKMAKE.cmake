#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ alien ############
# Alien converts an RPM package file into a Debian package file or Alien can install an RPM file directly. 
dk_installPackage(alien)
dk_findProgram(ALIEN_EXE alien)
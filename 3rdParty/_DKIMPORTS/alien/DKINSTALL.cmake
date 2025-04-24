#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ alien ############
# Alien converts an RPM package file into a Debian package file or Alien can install an RPM file directly. 

dk_installPackage(alien)
dk_findProgram(ALIEN_EXE alien)
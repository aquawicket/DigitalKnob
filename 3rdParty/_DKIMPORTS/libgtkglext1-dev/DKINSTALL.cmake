#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############# libgtkglext1-dev ############

dk_load(dk_builder)
if(NOT LINUX_HOST)
	dk_undepend(libgtkglext1-dev)
	dk_return()
endif()

### INSTALL ###
dk_installPackage(libgtkglext1-dev)

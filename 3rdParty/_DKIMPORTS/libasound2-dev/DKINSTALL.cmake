#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ libasound2-dev ############
dk_load(dk_builder)

if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(libasound2-dev)
	dk_return()
endif()
if("$ENV{WSL_DISTRO_NAME}" STREQUAL "Alpine")
	dk_undepend(libasound2-dev)
	dk_return()
endif()

### INSTALL ###
dk_installPackage(libasound2-dev)

### Tiny Core Linux ###
#if(TINYCORE)
#	dk_command(tce-load -wi libasound2-dev)
#endif()

### LINK ###
dk_include(/usr/include/alsa)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lasound")

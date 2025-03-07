#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ mesa ############
# https://www.mesa3d.org
dk_load(dk_builder)
if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(mesa)
	dk_return()
endif()

### INSTALL ###
if("$ENV{WSL_DISTRO_NAME}" STREQUAL "Alpine")
	dk_installPackage(mesa-dev)
else()
	dk_installPackage(mesa-common-dev)
endif()

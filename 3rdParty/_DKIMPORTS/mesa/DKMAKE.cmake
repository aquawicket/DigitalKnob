#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://www.mesa3d.org

if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(mesa)
	dk_return()
endif()


### INSTALL ###
if("$ENV{WSL_DISTRO_NAME}" STREQUAL "Alpine")
	dk_installPackage(mesa)
	dk_installPackage(mesa-dri-gallium)
	dk_installPackage(mesa-va-gallium)
	dk_installPackage(mesa-dev)
else()
	dk_installPackage(mesa-common-dev)
endif()

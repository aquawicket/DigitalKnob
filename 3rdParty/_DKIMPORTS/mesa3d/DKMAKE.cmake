#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://www.mesa3d.org

if(NOT LINUX AND NOT RASPBERRY)
	dk_undepend(mesa3d)
	dk_return()
endif()


### INSTALL ###
#dk_cd(/usr)
if("$ENV{WSL_DISTRO_NAME}" STREQUAL "Alpine")
	dk_installPackage(mesa-dev)
else()
	dk_installPackage(mesa-common-dev)
endif()

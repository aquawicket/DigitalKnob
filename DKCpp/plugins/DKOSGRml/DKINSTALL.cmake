#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ DKOSGRml ############
dk_depend(DKRml)
dk_depend(DKOSGWindow)
#dk_depend(openscenegraph osgdb_jpeg)
#dk_depend(openscenegraph osgdb_gif)
#dk_depend(openscenegraph osgdb_tiff)
#dk_depend(openscenegraph osgdb_bmp)
#dk_depend(openscenegraph osgdb_png)
#dk_depend(openscenegraph osgdb_freetype)





############ DKOSGRml ############
dk_set(CURRENT_PLUGIN "DKOSGRml")
dk_generateCmake(${CURRENT_PLUGIN})
dk_assets(${CURRENT_PLUGIN})
dk_set(${CURRENT_PLUGIN} "${CMAKE_CURRENT_LIST_DIR}")
dk_configure(${CMAKE_CURRENT_LIST_DIR})
dk_build(${CMAKE_CURRENT_LIST_DIR})

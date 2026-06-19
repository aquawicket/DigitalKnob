#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


dk_importVariables(IMPORT_PATH "${CMAKE_CURRENT_LIST_DIR}" INSTALL_PATH "${CMAKE_CURRENT_LIST_DIR}")

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
dk_generateCmake()
dk_assets()
dk_configure()
dk_build()

#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


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
dk_configure(${${CURRENT_PLUGIN}})
dk_build(${${CURRENT_PLUGIN}})

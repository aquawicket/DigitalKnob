#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DKOSGRml ############
dk_depend(DKRml)
dk_depend(DKOSGWindow)
#dk_depend(openscenegraph osgdb_jpeg)
#dk_depend(openscenegraph osgdb_gif)
#dk_depend(openscenegraph osgdb_tiff)
#dk_depend(openscenegraph osgdb_bmp)
#dk_depend(openscenegraph osgdb_png)
#dk_depend(openscenegraph osgdb_freetype)

dk_generateCmake(DKOSGRml)

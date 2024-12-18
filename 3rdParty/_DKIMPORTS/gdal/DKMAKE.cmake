#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ gdal ############
# https://github.com/OSGeo/gdal.git
dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/OSGeo/gdal/archive/5deb1267.zip)

# TODO

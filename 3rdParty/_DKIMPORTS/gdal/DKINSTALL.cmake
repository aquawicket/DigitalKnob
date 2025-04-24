#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ gdal ############
# https://github.com/OSGeo/gdal.git

dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/OSGeo/gdal/archive/5deb1267.zip)

# TODO

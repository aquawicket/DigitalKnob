#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/OSGeo/gdal.git


### IMPORT ###
#dk_import(https://github.com/OSGeo/gdal.git)
dk_import(https://github.com/OSGeo/gdal/archive/refs/heads/master.zip)



# TODO
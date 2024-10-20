#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/OSGeo/gdal.git


### IMPORT ###
dk_import(https://github.com/OSGeo/gdal/archive/5deb12670d39b035d30d049a1602e444c329757b.zip)
#dk_import(https://github.com/OSGeo/gdal/archive/refs/heads/master.zip)



# TODO
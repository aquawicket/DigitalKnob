#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/dzzie/duk4vb.git
# http://sandsprite.com/tools.php?id=23


### IMPORT ###
#dk_import(https://github.com/dzzie/duk4vb.git)
dk_import(http://sandsprite.com/CodeStuff/duk4vb-master.zip)

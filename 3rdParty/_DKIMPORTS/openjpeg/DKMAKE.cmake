#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ openjpeg ############
# https://github.com/uclouvain/openjpeg

dk_load(dk_builder)

### IMPORT ###
#dk_import(https://github.com/uclouvain/openjpeg.git)
dk_import(https://github.com/uclouvain/openjpeg/archive/refs/heads/master.zip)


# TODO

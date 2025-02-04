#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ freeimage ############
# https://freeimage.sourceforge.io

dk_load(dk_builder)

### IMPORT ###
dk_import(https://gigenet.dl.sourceforge.net/project/freeimage/Source%20Distribution/3.18.0/FreeImage3180.zip)


# TODO
#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ openmw ############
# https://github.com/OpenMW/openmw.git

dk_load(dk_builder)

### IMPORT ###
#dk_import(https://github.com/OpenMW/openmw.git BRANCH master)
dk_import(https://github.com/OpenMW/openmw/archive/refs/heads/master.zip)

# TODO

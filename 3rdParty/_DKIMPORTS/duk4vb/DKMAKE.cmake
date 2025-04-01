#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ duk4vb ############
# https://github.com/dzzie/duk4vb.git
# http://sandsprite.com/tools.php?id=23

dk_load(dk_builder)

### IMPORT ###
#dk_import(https://github.com/dzzie/duk4vb.git)
dk_import(http://sandsprite.com/CodeStuff/duk4vb-master.zip)

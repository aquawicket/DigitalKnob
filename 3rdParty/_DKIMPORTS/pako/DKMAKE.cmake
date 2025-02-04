#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ pako ############
# https://github.com/nodeca/pako.git

dk_load(dk_builder)

### IMPORT ###
#dk_import(https://github.com/nodeca/pako.git)
dk_import(https://github.com/nodeca/pako/archive/refs/heads/master.zip)


# TODO

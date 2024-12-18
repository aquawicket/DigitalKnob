#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### shc ######
# https://github.com/neurobin/shc.git

dk_load(dk_builder)

#dk_import(https://github.com/neurobin/shc.git)
dk_import(https://github.com/neurobin/shc/archive/refs/heads/master.zip)

#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/SoftwareNetwork/sw

#WIN_dk_import(https://github.com/SoftwareNetwork/sw.git)
WIN_dk_import(https://github.com/SoftwareNetwork/sw/archive/refs/heads/b0.4.5.zip)

#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ dukglue ############
# https://github.com/Aloshi/dukglue.git

dk_load(dk_builder)

dk_depend(duktape)

dk_import(https://github.com/Aloshi/dukglue/archive/c3ec2a4.zip)

dk_include(${DUKGLUE}/include)

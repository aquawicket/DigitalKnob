#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ cpiogz2tar ############
# https://github.com/zkedem/cpiogz2tar

dk_import(https://github.com/zkedem/cpiogz2tar/archive/1c3ea92.zip)

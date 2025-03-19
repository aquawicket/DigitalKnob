#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ bcm_host ############
#

dk_validate(target_triple "dk_target_triple()")


if(RASPBERRY)
	dk_lib	(bcm_host)
endif()

#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ bcm_host ############
#

dk_validate(Target_Triple "dk_Target_Triple()")

if(RASPBERRY)
	dk_lib	(bcm_host)
endif()

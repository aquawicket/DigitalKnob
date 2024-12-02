#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)



############ bcm_host ############
dk_validate(target_triple "dk_target_triple()")
# bcm_host

if(RASPBERRY)
	dk_lib	(bcm_host)
endif()

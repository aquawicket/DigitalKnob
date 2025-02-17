#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ libstdc++fs ############
dk_validate(target_triple "dk_target_triple()")


if(LINUX OR RASPBERRY)
	dk_lib(libstdc++fs.a)
endif()

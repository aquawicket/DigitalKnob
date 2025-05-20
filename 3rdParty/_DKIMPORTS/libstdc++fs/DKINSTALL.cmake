#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ libstdc++fs ############
dk_validate(Target_Tuple "dk_Target_Tuple()")


if(Linux OR Raspberry)
	dk_lib(libstdc++fs.a)
endif()

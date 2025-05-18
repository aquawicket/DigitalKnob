#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### setipapi ######
# https://learn.microsoft.com/en-us/windows/win32/api/setupapi

dk_validate(Target_Tuple "dk_Target_Tuple()")

if(NOT Windows)
	dk_undepend(setupapi)
	dk_return()
endif()

dk_findLibrary(Setupapi.lib)



# MSYS2 (-lsetupapi)
if(MSYSTEM)
	dk_set(SETUPAPI_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lsetupapi")
endif()

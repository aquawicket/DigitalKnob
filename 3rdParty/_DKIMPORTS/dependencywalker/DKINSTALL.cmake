#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ dependencywalker ############
# https://www.dependencywalker.com

dk_validate(Host_Tuple "dk_Host_Tuple()")
if(NOT Win_Host)
	dk_undepend(dependencywalker)
	dk_return()
endif()

if(Win_X86_Host)
	dk_import	(https://www.dependencywalker.com/depends22_x86.zip)
elseif(Win_X86_64_Host)
	dk_import	(https://www.dependencywalker.com/depends22_x64.zip)
endif()

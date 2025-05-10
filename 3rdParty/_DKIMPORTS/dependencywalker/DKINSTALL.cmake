#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ dependencywalker ############
# https://www.dependencywalker.com

dk_validate(Host_Tuple "dk_Host_Tuple()")
if(NOT WIN_HOST)
	dk_undepend(dependencywalker)
	dk_return()
endif()

if(WIN_X86_HOST)
	dk_import	(https://www.dependencywalker.com/depends22_x86.zip)
elseif(WIN_X86_64_HOST)
	dk_import	(https://www.dependencywalker.com/depends22_x64.zip)
endif()

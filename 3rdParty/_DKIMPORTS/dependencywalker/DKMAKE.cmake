#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://www.dependencywalker.com

if(NOT WIN_HOST)
	dk_undepend(dependencywalker)
	dk_return()
endif()



WIN_X86_HOST_dk_import		(https://www.dependencywalker.com/depends22_x86.zip)
WIN_X86_64_HOST_dk_import	(https://www.dependencywalker.com/depends22_x64.zip)

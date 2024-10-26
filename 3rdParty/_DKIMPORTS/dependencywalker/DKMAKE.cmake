#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ dependencywalker ############
# https://www.dependencywalker.com
dk_load(dk_builder)
if(NOT WIN_HOST)
	dk_undepend(dependencywalker)
	dk_return()
endif()

if(WIN_X86_HOST)
	dk_import	(https://www.dependencywalker.com/depends22_x86.zip)
elseif(WIN_X86_64_HOST)
	dk_import	(https://www.dependencywalker.com/depends22_x64.zip)
endif()

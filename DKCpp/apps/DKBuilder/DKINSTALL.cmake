#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


dk_validate(Config_Path  "dk_Config_Path()")

dk_depend(DK)
dk_depend(DKArchive)
dk_depend(DKAssets)
dk_depend(DKBuild)
dk_depend(DKDebug)
#dk_depend(DKDukDebugger)
dk_depend(DKDuktape)
dk_depend(DKDuktapeDom)
dk_depend(DKFile)
dk_depend(DKGit)

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


############ git ############
# https://git-scm.com
# https://github.com/git-for-windows/git

dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_validate(Host_Tuple "dk_Host_Tuple()")
set(git_Import "${git_${Host_Tuple}_Import}")
dk_assertVar(git_Import)
dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
dk_importVariables(${git_Import} IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR} INSTALL_ROOT $ENV{DKTOOLS_DIR})
dk_assertVar(git)

if(NOT EXISTS ${git})
	dk_notice("git is not installed")
	dk_return()
endif()

dk_echo("Uninstalling git . . .")
dk_delete(${git})

if(NOT EXISTS ${git})
	dk_success("git uninstall complete")
else()
	dk_error("git uninstall failed")
endif()

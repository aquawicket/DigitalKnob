#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ git ############
# https://git-scm.com
# https://github.com/git-for-windows/git

set(git_Import "${git_${Host_Tuple}_Import}")
dk_assertVar(git_Import)
dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
dk_importVariables(${git_Import} IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR} INSTALL_ROOT ${DKTOOLS_DIR})
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

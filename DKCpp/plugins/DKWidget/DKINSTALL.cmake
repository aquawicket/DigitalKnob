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


dk_importVariables(IMPORT_PATH "${CMAKE_CURRENT_LIST_DIR}" INSTALL_PATH "${CMAKE_CURRENT_LIST_DIR}")

############ DKWidget ############
## dk_depend(DKRml)
## dk_depend(DKMySql)
## dk_depend(DKWindow)
## dk_depend(DKGui)
if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()
if(HAVE_DKCef)
	dk_validate(DKCef "dk_depend(DKCef)")
endif()


############ DKWidget ############
#dk_generateCmake("${${CURRENT_PLUGIN}}")
#dk_assets("${CMAKE_CURRENT_LIST_DIR}")
#dk_set(${CURRENT_PLUGIN} "${CMAKE_CURRENT_LIST_DIR}")
#dk_configure(${${CURRENT_PLUGIN}})
#dk_build(${${CURRENT_PLUGIN}})

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

############ DKCodeMirror ############
dk_depend(codemirror)
dk_copy(${CODEMIRROR}/lib/ ${DKCPP_PLUGINS_DIR}/DKCodeMirror/lib/ OVERWRITE)
dk_copy(${CODEMIRROR}/theme/ ${DKCPP_PLUGINS_DIR}/DKCodeMirror/theme/ OVERWRITE)
dk_copy(${CODEMIRROR}/mode/ ${DKCPP_PLUGINS_DIR}/DKCodeMirror/mode/ OVERWRITE)


dk_assets(DKCodeMirror)
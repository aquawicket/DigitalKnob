#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKCodeMirror ############
dk_depend(codemirror)
dk_copy(${CODEMIRROR}/lib/ ${DKCPP_PLUGINS_DIR}/DKCodeMirror/lib/ OVERWRITE)
dk_copy(${CODEMIRROR}/theme/ ${DKCPP_PLUGINS_DIR}/DKCodeMirror/theme/ OVERWRITE)
dk_copy(${CODEMIRROR}/mode/ ${DKCPP_PLUGINS_DIR}/DKCodeMirror/mode/ OVERWRITE)
dk_assets(DKCodeMirror)
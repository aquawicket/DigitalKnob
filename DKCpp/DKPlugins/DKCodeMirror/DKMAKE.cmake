#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DKCodeMirror ############
dk_depend(codemirror)
dk_copy(${CODEMIRROR}/lib/ ${DKPLUGINS_DIR}/DKCodeMirror/lib/ OVERWRITE)
dk_copy(${CODEMIRROR}/theme/ ${DKPLUGINS_DIR}/DKCodeMirror/theme/ OVERWRITE)
dk_copy(${CODEMIRROR}/mode/ ${DKPLUGINS_DIR}/DKCodeMirror/mode/ OVERWRITE)
dk_assets(DKCodeMirror)
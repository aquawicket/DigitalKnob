#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ codemirror ############
# https://github.com/codemirror/CodeMirror.git
dk_load(dk_builder)

dk_import(https://github.com/codemirror/codemirror5/archive/998f328.zip)

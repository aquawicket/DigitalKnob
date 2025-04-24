#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ codemirror ############
# https://github.com/codemirror/CodeMirror.git

dk_load(dk_builder)

dk_import(https://github.com/codemirror/codemirror5/archive/998f328.zip)

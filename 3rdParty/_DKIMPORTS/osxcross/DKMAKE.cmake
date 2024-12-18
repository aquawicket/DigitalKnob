#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ osxcross ############
# https://github.com/tpoechtrager/osxcross

dk_import(https://github.com/tpoechtrager/osxcross/archive/29fe6dd3.zip)

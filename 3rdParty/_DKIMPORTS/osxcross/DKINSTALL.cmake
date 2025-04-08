#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ osxcross ############
# https://github.com/tpoechtrager/osxcross

dk_import(https://github.com/tpoechtrager/osxcross/archive/29fe6dd3.zip)

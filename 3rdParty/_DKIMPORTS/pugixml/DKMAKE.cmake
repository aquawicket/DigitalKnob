#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/zeux/pugixml


### IMPORT ###
#dk_import(https://github.com/zeux/pugixml.git)
dk_import(https://github.com/zeux/pugixml/releases/download/v1.6/pugixml-1.6.zip PATCH)


if(ANDROID)
	dk_define(PUGIXML_NO_EXCEPTIONS)
endif()

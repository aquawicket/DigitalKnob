#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


# https://github.com/tpoechtrager/osxcross


dk_import(https://github.com/tpoechtrager/osxcross/archive/29fe6dd35522073c9df5800f8cd1feb4b9a993a8.zip)

#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################



set(myVar "name")
if(myVar IN_LIST myList)
	message("FOUND myVar:${myVar} in list")
else()
	message("myVar:${myVar} NOT FOUND in list")
endif()


list(APPEND myList "abc")
list(APPEND myList "123")
list(APPEND myList "def")
list(APPEND myList "456")

set(myVar "123")
if(myVar IN_LIST myList)
	message("FOUND myVar:${myVar} in list")
else()
	message("myVar:${myVar} NOT FOUND in list")
endif()

set(myVar "zzz")
if(myVar IN_LIST myList)
	message("FOUND myVar:${myVar} in list")
else()
	message("myVar:${myVar} NOT FOUND in list")
endif()





message("myList = ${myList}")
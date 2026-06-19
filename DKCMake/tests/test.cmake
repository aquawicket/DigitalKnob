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



set(myVar "name")
if(myVar IN_LIST myList)
	dk_echo("FOUND myVar:${myVar} in list")
else()
	dk_echo("myVar:${myVar} NOT FOUND in list")
endif()


list(APPEND myList "abc")
list(APPEND myList "123")
list(APPEND myList "def")
list(APPEND myList "456")

set(myVar "123")
if(myVar IN_LIST myList)
	dk_echo("FOUND myVar:${myVar} in list")
else()
	dk_echo("myVar:${myVar} NOT FOUND in list")
endif()

set(myVar "zzz")
if(myVar IN_LIST myList)
	dk_echo("FOUND myVar:${myVar} in list")
else()
	dk_echo("myVar:${myVar} NOT FOUND in list")
endif()





dk_echo("myList = ${myList}")
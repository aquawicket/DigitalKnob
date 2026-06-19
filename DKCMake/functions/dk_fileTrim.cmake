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


############################################################################
# dk_fileTrim(file)
#
#		Remove all of the empty lines from a file
#
#	Reference: https://stackoverflow.com/a/45021815
#
function(dk_fileTrim)
 	dk_debugFunc(1)
	
	set(file ${ARGV0})
	
	#findstr /rc:"[^ 	]" "%file%"> "%file%.tmp"
	#move /y "%file%.tmp" "%file%"
endfunction()











###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	set(file "${DKCACHE_DIR}/dk_fileTrim_TEST.txt")

	fileWrite(${file} "###########")
	fileWrite(${file} "")
	fileWrite(${file} " 2 ")
	fileWrite(${file} " ")
	fileWrite(${file} " 4 ")
	fileWrite(${file} "  ")
	fileWrite(${file} " 6 ")
	fileWrite(${file} "	")
	fileWrite(${file} " 8 ")
	fileWrite(${file} " 	")
	fileWrite(${file} " 10 ")
	fileWrite(${file} "	 ")
	fileWrite(${file} " 12 ")
	fileWrite(${file} "	 	")
	fileWrite(${file} " 14 ")
	fileWrite(${file} " 	 ")
	fileWrite(${file} "###########")
	
	message("###### Before dk_fileTrim ######")
	#type "%file%"
	message("")
	
	dk_fileTrim("${file}")
	
	message("###### After dk_fileTrim ######")
	#type "%file%"
	message("")

endfunction()


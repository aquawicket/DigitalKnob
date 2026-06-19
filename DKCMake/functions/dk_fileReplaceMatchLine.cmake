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


###############################################################################
# dk_fileReplaceMatchLine(file, find, replace)
#
#		replace lines containg search pattern. Any line containing the search 
#     pattern will be replaces with the new string
#
#	@file		- Path to the file to be altered.
#	@find		- The string to search for in the file.
#	@replace	- The string to replace the line(s) with
#
function(dk_fileReplaceMatchLine _file_ _find_)
	dk_debugFunc(3)
	
	set(_file_ ${ARGV0})
	set(_find_ ${ARGV1})
	string(REPLACE ";" "\;" _replace_ "${ARGV2}")
	
	file(STRINGS ${_file_} lines)
	if(EXISTS "${_file_}.new")
		dk_delete("${_file_}.new")
	endif()
	foreach(line ${lines})
		if(line MATCHES ${_find_})
			set(line "${_replace_}")
		endif()
		dk_fileAppend("${_file_}.new" "${line}")
	endforeach()
	
	dk_move("${_file_}.new" "${_file_}" OVERWRITE)
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(file "dk_fileReplaceMatchLine_TEST.txt")
	dk_fileWrite("${file}" "one\n")
	dk_fileAppend("${file}" "two\n")
	dk_fileAppend("${file}" "three\n")
	dk_fileAppend("${file}" "four\n")
	dk_fileAppend("${file}" "three\n")
	dk_fileAppend("${file}" "five\n")
	dk_fileReplaceMatchLine("${file}" hre " 'this string was replaced' ")
endfunction()


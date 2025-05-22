#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

################################################################################
# dk_fileToMatrix(path grid)
#
#
function(dk_fileToMatrix)
	dk_debugFunc(2)

	dk_todo("dk_fileToMatrix incomplete")
	
	set(file ${ARGV0})
	file(READ "${file}" file_content)
	string(REGEX REPLACE "\n" ";" file_lines "${file_content}")

	set(row 0)
	foreach(line ${file_lines})
		message("${row}: line = ${line}")
		set(column 0)
		string(REGEX REPLACE " " ";" words "${line}")
		message("${column}: words = ${words}")
#		foreach(word ${words})
#			message("${column}:word = ${word}")
#
#			TODO:  array[$row,$column]=${word}
#
#			math(EXPR column "column + 2")
#		endforeach()
		math(EXPR row "row + 1")
	endforeach()
#	
	### return value ###
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_fileToMatrix("$ENV{DKCMAKE_FUNCTIONS_DIR_}fileToVariable.txt" myArray)
	#dk_printVar(myArray)
	
#	message("${myArray[0,0]:0:1}")
#	message("myArray[0,0] = ${myArray[0,0]}")
#	message("myArray[1,1] = ${myArray[1,1]}")
#	message("myArray[2,2] = ${myArray[2,2]}")
	
#	foreach(key "${!myArray[@]}")
#		message("$key: ${myArray[$key]})"
#	endforeach()
endfunction()

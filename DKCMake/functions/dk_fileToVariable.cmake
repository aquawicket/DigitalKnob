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


#########################################################################
# dk_fileToVariable(<path>, <var>:optional)
#
#
function(dk_fileToVariable)
	dk_debugFunc(1 2)

	set(file ${ARGV0})
	set(rtn_var ${ARGV1})
	file(READ "${file}" dk_fileToVariable)

	set(dk_fileToVariable ${dk_fileToVariable} PARENT_SCOPE)
	if(rtn_var)
		set(${rtn_var} ${dk_fileToVariable} PARENT_SCOPE)
	endif()
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	###### Create test file ######
	dk_fileWrite("$ENV{DKCMAKE_FUNCTIONS_DIR_}fileToVariable.txt" "00 01 02 03 04 05 06 07 08 09 a\n")
	dk_fileAppend("$ENV{DKCMAKE_FUNCTIONS_DIR_}fileToVariable.txt" "10 11 12 13 14 15 16 17 18 19 a b\n")
	dk_fileAppend("$ENV{DKCMAKE_FUNCTIONS_DIR_}fileToVariable.txt" "20 21 22 23 24 25 26 27 28 29 a b c\n")
	dk_fileAppend("$ENV{DKCMAKE_FUNCTIONS_DIR_}fileToVariable.txt" "30 31 32 33 34 35 36 37 38 39 a b c d\n")
	dk_fileAppend("$ENV{DKCMAKE_FUNCTIONS_DIR_}fileToVariable.txt" "40 41 42 43 44 45 46 47 48 49 a b c d e\n")
	dk_fileAppend("$ENV{DKCMAKE_FUNCTIONS_DIR_}fileToVariable.txt" "50 51 52 53 54 55 56 57 58 59 a b c d e f\n")
	dk_fileAppend("$ENV{DKCMAKE_FUNCTIONS_DIR_}fileToVariable.txt" "60 61 62 63 64 65 66 67 68 69 a b c d e f g\n")
	dk_fileAppend("$ENV{DKCMAKE_FUNCTIONS_DIR_}fileToVariable.txt" "70 71 72 73 74 75 76 77 78 79 a b c d e f g h\n")
	dk_fileAppend("$ENV{DKCMAKE_FUNCTIONS_DIR_}fileToVariable.txt" "80 81 82 83 84 85 86 87 88 89 a b c d e f g h i\n")
	dk_fileAppend("$ENV{DKCMAKE_FUNCTIONS_DIR_}fileToVariable.txt" "90 91 92 93 94 95 96 97 98 99 a b c d e f g h i j\n")


	dk_fileToVariable("$ENV{DKCMAKE_FUNCTIONS_DIR_}fileToVariable.txt")
	dk_printVar(dk_fileToVariable)
	
	dk_fileToVariable("$ENV{DKCMAKE_FUNCTIONS_DIR_}fileToVariable.txt" myVar)
	dk_printVar(myVar)
endfunction()

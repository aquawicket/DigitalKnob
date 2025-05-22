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

###############################################################################
# dk_pad(str padchar left right align rtn_var)
#
#	Pad the end of a string to length with a given character
#
#   @str		- The string to pad
#   @padchar	- The fill character to use
#	  @left		- The number of left spaces to pad
#	  @right	- The number of right spaces to pad
#	  @align	- Align text to either side  (L) or (R)
#	  @rtn_var	- The returned string w/padding
#
function(dk_pad str padchar left right align rtn_var)
	dk_debugFunc()
	
	string(LENGTH "${str}" strlen)
	math(EXPR right_length "${right} - ${strlen}")
	math(EXPR left_length "${left}")

	if(left_length GREATER 0)
		if(${CMAKE_VERSION} VERSION_LESS "3.14")
			dk_unset(pad_left)
			foreach(i RANGE 1 ${left_length}) # inclusive
				string(APPEND pad_left ${padchar})
			endforeach()
		else()
			string(REPEAT ${padchar} ${left_length} pad_left)
		endif()
		string(APPEND padL ${pad_left})
	endif()
	
	if(right_length GREATER 0)
		if(${CMAKE_VERSION} VERSION_LESS "3.14")
			dk_unset(pad_right)
			foreach(i RANGE 1 ${right_length}) # inclusive
				string(APPEND pad_right ${padchar})
			endforeach()
		else()
			string(REPEAT ${padchar} ${right_length} pad_right)
		endif()
		string(APPEND padR ${pad_right})
	endif()

	#dk_printVar(pad)
	if("${align}" STREQUAL "L")
		set(${rtn_var} "${padL}${str}${padR}" PARENT_SCOPE)
	elseif("${align}" STREQUAL "R")
		set(${rtn_var} "${padR}${str}${padL}" PARENT_SCOPE)
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_pad("padded string A" " " 3 18 L strA)
	message("${strA}")

	dk_pad("string B" " " 3 18 L strB)
	message("${strB}")
	
	dk_pad("str C" " " 3 18 L strC)
	message("${strC}")
	
	dk_pad("padded string D" " " 3 18 R strD)
	message("${strD}")

	dk_pad("string E" " " 3 18 R strE)
	message("${strE}")
	
	dk_pad("str F" " " 3 18 R strF)
	message("${strF}")
	
	
	message("${strA} ${strD}")
	message("${strB} ${strE}")
	message("${strC} ${strF}")
endfunction()
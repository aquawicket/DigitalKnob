#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_pad(str padchar left-length right-length align rtn_var)
#
#	Pad the end of a string to length with a given character
#
#   @str		- The string to pad
#   @padchar	- The fill character to use
#	@length		- The number of spaces to pad
#	@rtn_var		- The returned string w/padding
#
function(dk_pad str padchar left right align rtn_var)
	dk_debugFunc()
	
	string(LENGTH "${str}" strlen)
	if("${align}" STREQUAL "L")
		math(EXPR right_length "${right} - ${strlen}")
		math(EXPR left_length "${left}")
	else()
		math(EXPR right_length "${right} - ${strlen}")
		math(EXPR left_length "${left}")
	endif()
	#message("strlen = ${strlen}")

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
	dk_debugFunc()
	
	dk_pad("padded string A" "*" 3 16 L strA)
	message("${strA}")

	dk_pad("string B" "*" 3 16 L strB)
	message("${strB}")
	
	dk_pad("str C" "*" 3 16 L strC)
	message("${strC}")
	
	dk_pad("padded string D" "*" 3 16 R strD)
	message("${strD}")

	dk_pad("string E" "*" 3 16 R strE)
	message("${strE}")
	
	dk_pad("str F" "*" 3 16 R strF)
	message("${strF}")
	
	
	message("${strA} ${strD}")
	message("${strB} ${strE}")
	message("${strC} ${strF}")
endfunction()
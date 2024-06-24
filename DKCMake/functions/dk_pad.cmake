include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_pad(str padchar length rtn_var)
#
#	Pad the end of a string to length with a given character
#
#   @str		- The string to pad
#   @padchar	- The fill character to use
#	@length		- The number of spaces to pad
#	@rtn_var		- The returned string w/padding
#
function(dk_pad str padchar length rtn_var)
	dk_debugFunc(${ARGV})
	

	string(LENGTH "${str}" strlen)
	math(EXPR strlen "${length} - ${strlen}")

	if(strlen GREATER 0)
		if(${CMAKE_VERSION} VERSION_LESS "3.14")
			dk_unset(_pad)
			foreach(i RANGE 1 ${strlen}) # inclusive
				string(APPEND _pad ${padchar})
			endforeach()
		else()
			string(REPEAT ${padchar} ${strlen} _pad)
		endif()
		string(APPEND pad ${_pad})
	endif()

	dk_printVar(pad)
  set(${rtn_var} "${pad}" PARENT_SCOPE)
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()
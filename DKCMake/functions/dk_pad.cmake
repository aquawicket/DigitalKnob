include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


###############################################################################
# dk_pad(str padchar length RESULT)
#
#	Pad the end of a string to length with a given character
#
#   @str		- The string to pad
#   @padchar	- The fill character to use
#	@length		- The number of spaces to pad
#	@RESULT		- The returned string w/padding
#
function(dk_pad str padchar length RESULT)
	#DKDEBUGFUNC(${ARGV})
	string(LENGTH "${str}" _strlen)
	math(EXPR _strlen "${length} - ${_strlen}")

	if(_strlen GREATER 0)
		if(${CMAKE_VERSION} VERSION_LESS "3.14")
			unset(_pad)
			foreach(_i RANGE 1 ${_strlen}) # inclusive
				string(APPEND _pad ${padchar})
			endforeach()
		else()
			string(REPEAT ${padchar} ${_strlen} _pad)
		endif()
    string(APPEND str ${_pad})
  endif()

  set(${RESULT} "${str}" PARENT_SCOPE)
endfunction()
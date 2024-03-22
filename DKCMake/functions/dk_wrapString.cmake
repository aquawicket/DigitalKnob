include_guard()

###############################################################################
# dk_wrapString()
#
#	Function to wrap a given string into multiple lines at the given column position.
#
#	@VARIABLE	- The name of the CMake variable holding the string.
#	@AT_COLUMN	- The column position at which string will be wrapped.
#
function(dk_wrapString)
	DKDEBUGFUNC(${ARGV})
	set(oneValueArgs VARIABLE AT_COLUMN)
	cmake_parse_arguments(dk_wrapString "${options}" "${oneValueArgs}" "" ${ARGN})
    string(LENGTH ${${DK_WRAPSTRING_VARIABLE}} stringLength)
    math(EXPR offset "0")
    while(stringLength GREATER 0)
        if(stringLength GREATER ${DK_WRAPSTRING_AT_COLUMN})
            math(EXPR length "${DK_WRAPSTRING_AT_COLUMN}")
        else()
            math(EXPR length "${stringLength}")
        endif()
        string(SUBSTRING ${${DK_WRAPSTRING_VARIABLE}} ${offset} ${length} line)
        set(lines "${lines}\n${line}")
        math(EXPR stringLength "${stringLength} - ${length}")
        math(EXPR offset "${offset} + ${length}")
    endwhile()
    set(${DK_WRAPSTRING_VARIABLE} "${lines}" PARENT_SCOPE)
endfunction()
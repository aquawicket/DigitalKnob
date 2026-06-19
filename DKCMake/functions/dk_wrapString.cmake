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
# dk_wrapString()
#
#	Function to wrap a given string into multiple lines at the given column position.
#
#	@VARIABLE	- The name of the CMake variable holding the string.
#	@AT_COLUMN	- The column position at which string will be wrapped.
#
function(dk_wrapString)
	dk_debugFunc()
	
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





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_todo()
endfunction()
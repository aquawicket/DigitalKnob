#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


##################################################################################
# dk_trimNonAlphaNumeric(<input> <output>)
#
#
function(dk_trimNonAlphaNumeric)
	dk_debugFunc(1 2)
	
	set(_input_ "${ARGV0}")
	string(LENGTH "${_input_}" _string_length)

	set(front_index 0)
    foreach(index RANGE 0 ${_string_length})
        string(SUBSTRING "${_input_}" ${index} 1 _current_char)
		if(_current_char MATCHES "[A-Za-z0-9]")
			set(front_index ${index})
            break()
        endif()
    endforeach()
	
	foreach(index RANGE ${_string_length} 0)
        string(SUBSTRING "${_input_}" ${index} 1 _current_char)
		if(_current_char MATCHES "[A-Za-z0-9]")
			set(back_index ${index})
            break()
        endif()
    endforeach()
	
	math(EXPR sub_length "${back_index} - ${front_index}+1" OUTPUT_FORMAT DECIMAL)
	string(SUBSTRING "${ARGV0}" "${front_index}" "${sub_length}" dk_trimNonAlphaNumeric)


	###### output ######
	set(dk_trimNonAlphaNumeric ${dk_trimNonAlphaNumeric} PARENT_SCOPE)
	if(ARGV1)
		set(${ARGV1} ${dk_trimNonAlphaNumeric} PARENT_SCOPE)
	else()
		message("${dk_trimNonAlphaNumeric}")
	endif()
	#return($?)
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(myVar "++--#$@@0.2.134Beta-*@*@-")
	dk_trimNonAlphaNumeric("${myVar}" myVar)
	dk_echo("myVar = ${myVar}")
	dk_echo("dk_trimNonAlphaNumeric = ${dk_trimNonAlphaNumeric}")
endfunction()

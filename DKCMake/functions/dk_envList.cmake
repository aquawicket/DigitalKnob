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


#########################################################################
# dk_envList(<name> PUSH value)
# dk_envList(<name> POP)
#
#	Create a Global 'stack like" list variable. You can push to, and pop from the stack.
#   use $ENV{CURRENT_<name>} to get the topmost item.
#
function(dk_envList)
	dk_debugFunc()

	set(NAME "${ARGV0}")
	set(CMND "${ARGV1}")
	set(_CURRENT_ "${ARGV2}")
	
	# copy the env variable to local variable
	set(_STACK_ "$ENV{${NAME}_STACK}")  
	
	# set the _CURRENT_ item and push it to the local _STACK_ list.
	if("${CMND}" STREQUAL "PUSH")
		set(_STACK_ "${_CURRENT_};${_STACK_}")	
		#list(PREPEND _STACK_ "${_CURRENT_}")	# prepend the local variable
	endif()

	# Pop the CURRENT_<THING> and drop it fom the list. Update CURRENT_<THING>
	if("${CMND}" STREQUAL "POP")
		list(POP_FRONT _STACK_)
		list(LENGTH _STACK_ _LENGTH_)
		if(${_LENGTH_} GREATER 0)
			list(GET _STACK_ 0 _CURRENT_)
		else()
			set(_CURRENT_ "")
		endif()
	endif()
	
	dk_set(ENV{CURRENT_${NAME}} 	"${_CURRENT_}")
	dk_set(ENV{${NAME}_STACK} 		"${_STACK_}")  # copy local variable back to the environment variable
		
	#message("ENV{CURRENT_${NAME}} 	= $ENV{CURRENT_${NAME}}")
	#message("ENV{${NAME}_STACK}  	= $ENV{${NAME}_STACK}")
endfunction()














###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_envList(PLUGINS PUSH "ABC")
	dk_envList(PLUGINS PUSH "123")	
	dk_envList(PLUGINS PUSH "DEF")
	dk_envList(PLUGINS PUSH "456")
	
	dk_envList(PLUGINS POP)
	dk_envList(PLUGINS POP)
	dk_envList(PLUGINS POP)
	dk_envList(PLUGINS POP)
	dk_envList(PLUGINS POP)
endfunction()


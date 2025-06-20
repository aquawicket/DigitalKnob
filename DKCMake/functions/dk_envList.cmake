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
	
#	dk_toLower(${ARGV2} _current_)		# lowercase
	dk_toUpper(${ARGV2} _CURRENT_)		# UPPERCASE
#	set(_Current_ "${ARGV2}")			# Original
	
	# copy the env variable to local variable
#	set(_stack_ "$ENV{${NAME}_stack}")	# lowercase
	set(_STACK_ "$ENV{${NAME}_STACK}")	# UPPERCASE 
#	set(_Stack_ "$ENV{${NAME}_Stack}")	# Original
	
	# set the _CURRENT_ item and push it to the local _STACK_ list.
	if("${CMND}" STREQUAL "PUSH")
#		set(_stack_ "${_current_};${_stack_}")	# lowercase
		set(_STACK_ "${_CURRENT_};${_STACK_}")	# UPPERCASE
#		set(_Stack_ "${_Current_};${_Stack_}")	# Original
	endif()

	# Pop the CURRENT_<THING> and drop it fom the list. Update CURRENT_<THING>
	if("${CMND}" STREQUAL "POP")
#		list(POP_FRONT _stack_)	# lowercase
		list(POP_FRONT _STACK_)		# UPPERCASE
#		list(POP_FRONT _Stack_)	# Original
		
#		list(LENGTH _stack_ _length_)	# lowercase
		list(LENGTH _STACK_ _LENGTH_)	# UPPERCASE
#		list(LENGTH _Stack_ _Length_)	# Original
		
		# lowercase
#		if(${_length_} GREATER 0)
#			list(GET _stack_ 0 _current_)
#		else()
#			set(_current_ "")
#		endif()
		
		# UPPERCASE
		if(${_LENGTH_} GREATER 0)
			list(GET _STACK_ 0 _CURRENT_)
		else()
			set(_CURRENT_ "")
		endif()
		
		# Original
#		if(${_Length_} GREATER 0)
#			list(GET _Stack_ 0 _Current_)
#		else()
#			set(_Current_ "")
#		endif()
	endif()
	
#	dk_set(ENV{current_${NAME}} 	"${_current_}")		# lowercase
	dk_set(ENV{CURRENT_${NAME}} 	"${_CURRENT_}")		# UPPERCASE
#	dk_set(ENV{Current_${NAME}} 	"${_Current_}")		# Original
	
	# copy local variable back to the environment variable
#	dk_set(ENV{${NAME}_stack} 		"${_stack_}")  		# lowercase
	dk_set(ENV{${NAME}_STACK} 		"${_STACK_}")  		# UPPERCASE
#	dk_set(ENV{${NAME}_Stack} 		"${_Stack_}")  		# Original
		
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


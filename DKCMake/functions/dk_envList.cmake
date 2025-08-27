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

#	set(_Current_ "${ARGV2}")					# Original	
#	dk_toLower(${ARGV2} _current_)				# lowercase
	dk_toUpper(${ARGV2} _CURRENT_)				# UPPERCASE

	### copy the env variable to local variable ###
#	set(_Stack_ "$ENV{${NAME}_Stack}")			# Original
#	set(_stack_ "$ENV{${NAME}_stack}")			# lowercase
	set(_STACK_ "$ENV{${NAME}_STACK}")			# UPPERCASE 

	
	### set the _CURRENT_ item and push it to the local _STACK_ list ###
	if("${CMND}" STREQUAL "PUSH")
#		set(_Stack_ "${_Current_};${_Stack_}")	# Original
#		set(_stack_ "${_current_};${_stack_}")	# lowercase
		set(_STACK_ "${_CURRENT_};${_STACK_}")	# UPPERCASE

#		list(LENGTH _Stack_ _Length_)			# Original
#		list(LENGTH _stack_ _length_)			# lowercase
		list(LENGTH _STACK_ _LENGTH_)			# UPPERCASE
	endif()

	# Pop the CURRENT_<THING> and drop it fom the list. Update CURRENT_<THING>
	if("${CMND}" STREQUAL "POP")
	
#		list(POP_FRONT _Stack_)					# Original
#		list(POP_FRONT _stack_)					# lowercase
		list(POP_FRONT _STACK_)					# UPPERCASE

#		list(LENGTH _Stack_ _Length_)			# Original		
#		list(LENGTH _stack_ _length_)			# lowercase
		list(LENGTH _STACK_ _LENGTH_)			# UPPERCASE
	
#		if(${_Length_} GREATER 0)				# Original
#			list(GET _Stack_ 0 _Current_)
#		else()
#			set(_Current_ "")
#		endif()
		
#		if(${_length_} GREATER 0)				# lowercase
#			list(GET _stack_ 0 _current_)
#		else()
#			set(_current_ "")
#		endif()
		
		if(${_LENGTH_} GREATER 0)				# UPPERCASE
			list(GET _STACK_ 0 _CURRENT_)
		else()
			set(_CURRENT_ "")
		endif()
	endif()

#	dk_set(Current_${NAME} 	"${_Current_}")		# Original
#	dk_set(current_${NAME} 	"${_current_}")		# lowercase
	dk_set(CURRENT_${NAME} 	"${_CURRENT_}")		# UPPERCASE
	dk_set(${NAME} 	        "${_CURRENT_}")
	
	### copy local variable back to the environment variable ###
#	dk_set(${NAME}_Stack 	"${_Stack_}")  		# Original
#	dk_set(${NAME}_stack 	"${_stack_}")  		# lowercase
	dk_set(${NAME}_STACK 	"${_STACK_}")  		# UPPERCASE

		
#	dk_debug("              NAME = ${NAME}")
#	dk_debug("              CMND = ${CMND}")
#	dk_debug("         _CURRENT_ = ${_CURRENT_}")
#	dk_debug("           _STACK_ = ${_STACK_}")
#	dk_debug("          _LENGTH_ = ${_LENGTH_}")
#	dk_debug("   CURRENT_${NAME} = ${CURRENT_${NAME}}")
#	dk_debug("     ${NAME}_STACK = ${${NAME}_STACK}")
#	dk_debug("      ${_CURRENT_} = ${${_CURRENT_}}")
#	dk_debug("  ${_CURRENT_}_DIR = ${${_CURRENT_}_DIR}")

	dk_title("${${NAME}_STACK}")
endfunction()














###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_echo("\nPushing Stack . . .")
	dk_echo("dk_envList(PLUGIN PUSH \"abc\")")
	dk_envList(PLUGIN PUSH "abc")
	dk_echo("PLUGIN = ${PLUGIN}")
	
	dk_echo("dk_envList(PLUGIN PUSH \"123\")")
	dk_envList(PLUGIN PUSH "123")
	dk_echo("PLUGIN = ${PLUGIN}")
	
	dk_echo("dk_envList(PLUGIN PUSH \"def\")")
	dk_envList(PLUGIN PUSH "def")
	dk_echo("PLUGIN = ${PLUGIN}")
	
	dk_echo("dk_envList(PLUGIN PUSH \"456\")")
	dk_envList(PLUGIN PUSH "456")
	dk_echo("PLUGIN = ${PLUGIN}")
	
	dk_echo("\nPoping Stack . . .")
	dk_echo("dk_envList(PLUGIN POP)")
	dk_envList(PLUGIN POP)
	dk_echo("PLUGIN = ${PLUGIN}")
	
	dk_echo("dk_envList(PLUGIN POP)")
	dk_envList(PLUGIN POP)
	dk_echo("PLUGIN = ${PLUGIN}")
	
	dk_echo("dk_envList(PLUGIN POP)")
	dk_envList(PLUGIN POP)
	dk_echo("PLUGIN = ${PLUGIN}")
	
	dk_echo("dk_envList(PLUGIN POP)")
	dk_envList(PLUGIN POP)
	dk_echo("PLUGIN = ${PLUGIN}")
	
endfunction()


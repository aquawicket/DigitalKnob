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
# dk_envList(<LIST_NAME> PUSH <Import_Name>)
# dk_envList(<LIST_NAME> POP)
#
#	Create a Global 'stack like" list variable. You can push to, and pop from the stack.
#   use ${CURRENT_<name>} to get the topmost item.
#
function(dk_envList)
	dk_debugFunc()

	set(LIST_NAME   "${ARGV0}")
	set(CMND 		"${ARGV1}")
	set(Import_Name 	"${ARGV2}")	### push the value
	
	set(_Stack_ "$ENV{${LIST_NAME}_Stack}")		### copy the env variable to local variable
	
	### set the Import_Name item and push it to the local _Stack_ list ###
	if("${CMND}" STREQUAL "PUSH")
		set(_Stack_ "${Import_Name};${_Stack_}")
		list(LENGTH _Stack_ _Length_)
	endif()

	# Pop the CURRENT_<THING> and drop it fom the list. Update CURRENT_<THING>
	if("${CMND}" STREQUAL "POP")
		list(POP_FRONT _Stack_)
		list(LENGTH _Stack_ _Length_)
		if(${_Length_} GREATER 0)
			list(GET _Stack_ 0 Import_Name)
		else()
			set(Import_Name "")
		endif()
	endif()

	dk_set(CURRENT_${LIST_NAME} "${Import_Name}")	### set the global variable
	dk_set(${LIST_NAME}_Stack 	"${_Stack_}")	### copy local variable back to the environment variable

		
#	dk_debug("              LIST_NAME = ${LIST_NAME}")
#	dk_debug("                   CMND = ${CMND}")
#	dk_debug("            Import_Name = ${Import_Name}")
#	dk_debug("                _Stack_ = ${_Stack_}")
#	dk_debug("               _Length_ = ${_Length_}")
#	dk_debug("   CURRENT_${LIST_NAME} = ${CURRENT_${LIST_NAME}}")
#	dk_debug("     ${LIST_NAME}_Stack = ${${LIST_NAME}_Stack}")
#	dk_debug("         ${Import_Name} = ${${Import_Name}}")


	dk_title("${${LIST_NAME}_Stack}")
	#dk_debug("CURRENT_PLUGIN = ${CURRENT_PLUGIN}")
endfunction()














###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_echo()
	dk_echo("###### Pushing to stack #######")
	
	dk_echo()
	dk_echo("    CURRENT_PLUGIN = ${CURRENT_PLUGIN}")
	
	dk_echo()
	dk_echo("    dk_envList(PLUGIN PUSH \"abc\")")
	dk_envList(PLUGIN PUSH "abc")
	dk_echo("        CURRENT_PLUGIN = ${CURRENT_PLUGIN}")
	
	dk_echo()
	dk_echo("    dk_envList(PLUGIN PUSH \"123\")")
	dk_envList(PLUGIN PUSH "123")
	dk_echo("        CURRENT_PLUGIN = ${CURRENT_PLUGIN}")
	
	dk_echo()
	dk_echo("    dk_envList(PLUGIN PUSH \"def\")")
	dk_envList(PLUGIN PUSH "def")
	dk_echo("        CURRENT_PLUGIN = ${CURRENT_PLUGIN}")
	
	dk_echo()
	dk_echo("    dk_envList(PLUGIN PUSH \"456\")")
	dk_envList(PLUGIN PUSH "456")
	dk_echo("        CURRENT_PLUGIN = ${CURRENT_PLUGIN}")
	
	
	dk_echo()
	dk_echo()
	dk_echo("####### Poping Stack ######")
	
	dk_echo()
	dk_echo("    CURRENT_PLUGIN = ${CURRENT_PLUGIN}")
	
	dk_echo()
	dk_echo("    dk_envList(PLUGIN POP)")
	dk_envList(PLUGIN POP)
	dk_echo("        CURRENT_PLUGIN = ${CURRENT_PLUGIN}")
	
	dk_echo()
	dk_echo("    dk_envList(PLUGIN POP)")
	dk_envList(PLUGIN POP)
	dk_echo("        CURRENT_PLUGIN = ${CURRENT_PLUGIN}")
	
	dk_echo()
	dk_echo("    dk_envList(PLUGIN POP)")
	dk_envList(PLUGIN POP)
	dk_echo("        CURRENT_PLUGIN = ${CURRENT_PLUGIN}")
	
	dk_echo()
	dk_echo("    dk_envList(PLUGIN POP)")
	dk_envList(PLUGIN POP)
	dk_echo("        CURRENT_PLUGIN = ${CURRENT_PLUGIN}")
	
endfunction()


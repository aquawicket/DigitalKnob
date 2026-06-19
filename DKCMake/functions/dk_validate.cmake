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
# dk_validate(variable "code")
#
#	@variable  - The name of a variable to test
#	@code	   - The code to run if the variable is invalid. Like a function "dk_DIGITALKNOB_DIR()"
#
function(dk_validate) # variable code)
	dk_debugFunc(1 2)
	
#	message(" ARGV = ${ARGV}")
#	message(" ARGV0 = ${ARGV0}")
#	message(" ARGN = ${ARGN}")
#	if("${PrintArgData}" STREQUAL "1")
#		message(" ")
#		message("###### dk_validate() ${CMAKE_CURRENT_FUNCTION} ######")
#		#set(ARGV "${ARGV}")
#		#set(ARGN "${ARGN}")
#		
#		message(" ARGV = ${ARGV}")
#		set(n 0)
#		foreach(arg IN LISTS ARGV)
#			message("ARGV${n} = ${arg}")
#			math(EXPR n "${n}+1")
#		endforeach()
#		message(" ARGC = ${ARGC}")
#		
#		message(" ARGN = ${ARGN}")
#		set(ARGNC 0)
#		foreach(arg IN LISTS ARGN)
#			message("ARGV${ARGNC} = ${arg}")
#			math(EXPR ARGNC "${ARGNC}+1")
#		endforeach()
#		message("ARGNC = ${ARGNC}")
#		dk_printArgData()
#	endif()
	
#	dk_debugFunc(1 2)

#	if(NOT variable)
#		dk_warning("dk_append(${variable} ${code}) variable is invalid")
#		dk_return()
#	endif()
#	if(NOT code)
#		dk_warning("dk_append(${variable} ${code}) code is invalid")
#		dk_return()
#	endif()

	dk_validateFunc(dk_eval)
		
#	if(NOT ${ARGV0})
#		dk_call("${ARGV1}")
#	endif()

#	if(NOT ${VAR})
#		dk_call("${ARGN}")
#	endif()

	dk_validateFunc(dk_allButFirstArgs)
	dk_allButFirstArgs(${ARGV})
	if(NOT ${ARGV0})
		dk_call("${dk_allButFirstArgs}")
		#dk_eval("${dk_allButFirstArgs}")
	endif()
	
	#dk_debug("${variable} = ${${variable}}")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_validate(cmd.exe "dk_depend(cmd.exe)")
	message("cmd.exe = ${cmd.exe}")
	
	dk_validate(git "dk_depend(git)")
	dk_debug("git = ${git}")
endfunction()

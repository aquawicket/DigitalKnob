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
# dk_set(variable value)
#	
#	https://stackoverflow.com/a/29250496/688352
#
#	@VarName	The 'name' of a variable to set
#	@VarValue	The 'value' to set the variable to. 
#
function(dk_set VarName)
	if(COMMAND dk_debugFunc)
		dk_debugFunc(2 99)
	endif()
	if(ARGC LESS 2)
		dk_fatal("dk_set(${ARGV}): not enough arguments, expected at least 2, got ${ARGC}")
	endif()

	###### dk_set() Settings ######
	# if(NOT DEFINED dk_set_DEBUG)
	# 	set(dk_set_DEBUG 1)
	# endif()
	###############################

	string(REPLACE "ENV{" 	"" VarName "${ARGV0}")
	string(REPLACE "CACHE{" "" VarName "${VarName}")
	string(REPLACE "}" 		"" VarName "${VarName}")

	set(${VarName} "${ARGN}" CACHE INTERNAL "" FORCE) # The $CACHE{Var} syntax can be used to do direct cache entry lookups
	unset(${VarName} PARENT_SCOPE)
	set(ENV{${VarName}} "${ARGN}")
	
	#dk_debug("      ${VarName}  = ${${VarName}}")
	#dk_debug("CACHE{${VarName}} = $CACHE{${VarName}}")
	#dk_debug("  ENV{${VarName}} = $ENV{${VarName}}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_set(myVariableA "String Value of myVariableA")
	dk_set(myVariableA)

#	dk_set(myVariableB "String Value of myVariableB")
#	dk_echo("ENV{myVariableB} = $ENV{myVariableB}")

#	dk_set(CACHE{myVariableC} "String Value of myVariableC")
#	dk_echo("CACHE{myVariableC} = $CACHE{myVariableC}")

#	dk_set(myVariableA "String Value of myVariableA2")
#	dk_echo("myVariableA = ${myVariableA}")
	
#	dk_set(myVariableB "String Value of myVariableB2")
#	dk_echo("ENV{myVariableB} = $ENV{myVariableB}")

#	dk_set(CACHE{myVariableC} "String Value of myVariableC2")
#	dk_echo("CACHE{myVariableC} = $CACHE{myVariableC}")
endfunction()

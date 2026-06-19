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

if(NOT DEFINED dk_get_MISMATCH)
	set(dk_get_MISMATCH 1)
endif()
if(NOT DEFINED dk_get_ENABLE_ENV)
	set(dk_get_ENABLE_ENV 0)
endif()
if(NOT DEFINED dk_get_ENABLE_CACHE)
	set(dk_get_ENABLE_CACHE 1)
endif()
if(NOT DEFINED dk_get_ENABLE_LOCAL)
	set(dk_get_ENABLE_LOCAL 1)
endif()
#########################################################################
# dk_get(variable value)
#	
#	https://stackoverflow.com/a/29250496/688352
#
#	@variable	The name of a variable to declair
#	@value		The value to set the variable to. 
#
#	Order or presidence is   ENV, CACHE, LOCAL
#
function(dk_get variable) #, value)
	if(COMMAND dk_debugFunc)
		dk_debugFunc(1)
	endif()

	if(${ARGC} LESS 1)
		dk_fatal("dk_get(${ARGV}): not enough arguments, expected at least 1, got ${ARGC}")
	endif()

	string(REPLACE "CACHE{" "" Var "${Var}")
	string(REPLACE "ENV{" "" Var "${ARGV0}")
	string(REPLACE "}" "" Var "${Var}")

#	if(("${dk_get_ENABLE_ENV}" EQUAL "1") AND (DEFINED ENV{${Var}}))
#		dk_debug("  ENV{${Var}} = ${white}'$ENV{${Var}}'")
#	else()
#		dk_debug("  ENV{${Var}} = ${red}UNDEFINED")
#	endif()
#	if(DEFINED CACHE{${Var}})
#		dk_debug("CACHE{${Var}} = ${white}'$CACHE{${Var}}'")
#	else()
#		dk_debug("CACHE{${Var}} = ${red}UNDEFINED")
#	endif()
#	if(DEFINED ${Var})
#		dk_debug("     {${Var}} = ${white}'${${Var}}'")
#	else()
#		dk_debug("     {${Var}} = ${red}UNDEFINED")
#	endif()

	if("${dk_get_MISMATCH}" EQUAL "1")
		if(("${dk_get_ENABLE_ENV}" EQUAL "1") AND (DEFINED ENV{${Var}}))
			if(("${dk_get_ENABLE_CACHE}" EQUAL "1") AND (DEFINED CACHE{${Var}}))
				if(NOT "$ENV{${Var}}" STREQUAL "$CACHE{${Var}}")
					dk_error("ENV{${Var}}:'$ENV{${Var}}'  and  CACHE{${Var}}:'$CACHE{${Var}}' Do NOT Match")
				endif()
			endif()
		
			if(("${dk_get_ENABLE_LOCAL}" EQUAL "1") AND ${Var})
				if(NOT "$ENV{${Var}}" STREQUAL "${${Var}}")
					dk_error("ENV{${Var}}:'$ENV{${Var}}'  and  ${Var}:'${${Var}}' Do NOT Match")
				endif()
			endif()
		endif()
		
		if(("${dk_get_ENABLE_CACHE}" EQUAL "1") AND (DEFINED CACHE{${Var}}))
			if(("${dk_get_ENABLE_LOCAL}" EQUAL "1") AND ${Var})
				if(NOT "$CACHE{${Var}}" STREQUAL "${${Var}}")
					dk_error("CACHE{${Var}}:'$CACHE{${Var}}'  and  ${Var}:'${${Var}}' Do NOT Match")
				endif()
			endif()
		endif()
	endif()
	
	if(("${dk_get_ENABLE_ENV}" STREQUAL "1") AND (DEFINED ENV{${Var}}))
		set(${Var} "$ENV{${Var}}" PARENT_SCOPE)
	elseif(("${dk_get_ENABLE_CACHE}" STREQUAL "1") AND (DEFINED CACHE{${Var}}))
		set(${Var} "$CACHE{${Var}}" PARENT_SCOPE)
	elseif(("${dk_get_ENABLE_LOCAL}" STREQUAL "1") AND (DEFINED ${Var}) AND ${Var})
		set(${Var} "${${Var}}" PARENT_SCOPE)
	else()
		dk_error("\$ENV:\$CACHE:\${${Var}} UNDEFINED")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	### LOCAL value
	dk_echo()
	dk_unset(myVariableA)
	set(myVariableA "(LOCAL) value")
	dk_get(myVariableA)
	dk_debug("myVariableA = ${myVariableA}")
	
	### CACHE value
	dk_echo()
	dk_unset(myVariableA)
	set(myVariableA "(CACHE) value" CACHE INTERNAL "" FORCE)
	unset(myVariableA)
	dk_get(myVariableA)
	dk_debug("myVariableA = ${myVariableA}")
	
	### ENV value
	dk_echo()
	dk_unset(myVariableA)
	set(ENV{myVariableA} "(ENV) value")
	dk_get(myVariableA)
	dk_debug("myVariableA = ${myVariableA}")
	
	### CACHE and LOCAL value
	dk_echo()
	dk_unset(myVariableA)
	set(myVariableA "(CACHE) and LOCAL value" CACHE INTERNAL "" FORCE)
	set(myVariableA "CACHE and (LOCAL) value")
	dk_get(myVariableA)
	dk_debug("myVariableA = ${myVariableA}")
	
	### ENV and LOCAL value 
	dk_echo()
	dk_unset(myVariableA)
	set(ENV{myVariableA} "(ENV) and LOCAL value")
	set(myVariableA "ENV and (LOCAL) value")
	dk_get(myVariableA)
	dk_debug("myVariableA = ${myVariableA}")
		
	### ENV and CACHE value
	dk_echo()
	dk_unset(myVariableA)
	set(ENV{myVariableA} "(ENV) and CACHE value")
	set(myVariableA "ENV and (CACHE) value" CACHE INTERNAL "" FORCE)
	unset(myVariableA)
	dk_get(myVariableA)
	dk_debug("myVariableA = ${myVariableA}")
	
	### ENV, CACHE and LOCAL value
	dk_echo()
	dk_unset(myVariableA)
	set(ENV{myVariableA} "(ENV), CACHE and LOCAL value")
	set(myVariableA "ENV, (CACHE) and LOCAL value" CACHE INTERNAL "" FORCE)
	set(myVariableA "ENV, CACHE and (LOCAL) value")
	dk_get(myVariableA)
	dk_debug("myVariableA = ${myVariableA}")
	
	### NO value ###
	dk_echo()
	dk_unset(myVariableA)
	dk_get(myVariableA)
	dk_debug("myVariableA = ${myVariableA}")
	
	### ComSpec ###
	dk_echo()
	dk_get(ComSpec)
	dk_debug("ComSpec = ${ComSpec}")
	
endfunction()

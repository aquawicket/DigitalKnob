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
if(POLICY CMP0054) # https://cmake.org/cmake/help/latest/policy/CMP0054.html 3.1.0 Only interpret if() arguments as variables or keywords when unquoted.
	cmake_policy(SET CMP0054 NEW) 
endif()

#########################################################################
# dk_set(variable value)
#	
#	https://stackoverflow.com/a/29250496/688352
#
#	@variable	The name of a variable to declair
#	@value		The value to set the variable to. 
#
#	CMD:     local   cache   env
#   Cmake:   Local   cache   env
#
function(dk_set2 VarName)
	if(COMMAND dk_debugFunc)
		dk_debugFunc(2 99)
	endif()
	#if(ARGC LESS 2)
	#	dk_fatal("dk_set2(${ARGV}): not enough arguments, expected at least 2, got ${ARGC}")
	#endif()

	###### dk_set2() Settings ######
	#if(NOT DEFINED dk_set_DEBUG)
	#	set(dk_set_DEBUG 1)
	#endif()
	################################


#	###### return ######
#	#set(dk_set2 ${dk_set2} PARENT_SCOPE)
	if("${ARGV0}" MATCHES "ENV{")
		string(REPLACE "ENV{" "" ARGV0 "${ARGV0}")
		string(REPLACE "}" "" ARGV0 "${ARGV0}")
		if(ARGV1)
			set(ENV{${ARGV0}} "${ARGV1}")								# ENV variable
		endif()
	elseif("${ARGV0}" MATCHES "CACHE{")
		string(REPLACE "CACHE{" "" ARGV0 "${ARGV0}")
		string(REPLACE "}" "" ARGV0 "${ARGV0}")
		if(ARGV1)
			set(${ARGV0} "${ARGV1}" CACHE INTERNAL "" FORCE)			# CACHE variable
			unset(${ARGV0} PARENT_SCOPE) # Remove the local variable
		endif()
	elseif("${ARGV0}" MATCHES "GLOBAL{")
		string(REPLACE "GLOBAL{" "" ARGV0 "${ARGV0}")
		string(REPLACE "}" "" ARGV0 "${ARGV0}")
		if(ARGV1)
			set(${ARGV0} "${ARGV1}" CACHE INTERNAL "" FORCE)			# GLOBAL variable
			unset(${ARGV0} PARENT_SCOPE) # Remove the local variable
		endif()
	else()
		if(ARGV1)
			set(${ARGV0} "${ARGV1}" PARENT_SCOPE)						# LOCAL variable
		endif()
	endif()
	
	if(NOT ARGV1)
		message("")
		message("      ${ARGV0}   = ${${ARGV0}}")
		message("CACHE{${ARGV0}}  = $CACHE{${ARGV0}}")
		message("GLOBAL{${ARGV0}} = ${${ARGV0}}")
		message("  ENV{${ARGV0}}  = $ENV{${ARGV0}}")
	endif()

#	set(VarName "${ARGV0}")
#	string(REPLACE "ENV{" 	"" VarName "${VarName}")
#	string(REPLACE "CACHE{" "" VarName "${VarName}")
#	string(REPLACE "}" 		"" VarName "${VarName}")

#	set(${VarName} "${ARGN}" CACHE INTERNAL "" FORCE) # The $CACHE{Var} syntax can be used to do direct cache entry lookups
#	unset(${VarName} PARENT_SCOPE)
#	set(ENV{${VarName}} "${ARGN}")
	
#	message("      ${VarName}  = ${${VarName}}")
#	message("CACHE{${VarName}} = $CACHE{${VarName}}")
#	message("  ENV{${VarName}} = $ENV{${VarName}}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	if(COMMAND dk_debugFunc)
		dk_debugFunc(0)
	endif()

	dk_set2(myVarA "Value of myVarA (LOCAL)")
	dk_set2(myVarA)

	dk_set2(myVarB "Value of myVarB (LOCAL)")
	dk_set2(myVarB)
	
	dk_set2(myVarC "Value of myVarC (LOCAL)")
	dk_set2(myVarC)


	dk_set2(CACHE{myVarA} "Value of myVarA (CACHE)")
	dk_set2(CACHE{myVarA})
	
	dk_set2(CACHE{myVarB} "Value of myVarB (CACHE)")
	dk_set2(CACHE{myVarB})
	
	dk_set2(CACHE{myVarC} "Value of myVarC (CACHE)")
	dk_set2(CACHE{myVarC})
	
	
	dk_set2(ENV{myVarA} "Value of myVarA (ENV)")
	dk_set2(ENV{myVarA})
	
	dk_set2(ENV{myVarB} "Value of myVarB (ENV)")
	dk_set2(ENV{myVarB})
	
	dk_set2(ENV{myVarC} "Value of myVarC (ENV)")
	dk_set2(ENV{myVarC})

	dk_set2(GLOBAL{myVarA} "Value of myVarA (GLOBAL)")
	dk_set2(GLOBAL{myVarA})
	
	dk_set2(GLOBAL{myVarB} "Value of myVarB (GLOBAL)")
	dk_set2(GLOBAL{myVarB})
	
	dk_set2(GLOBAL{myVarC} "Value of myVarC (GLOBAL)")
	dk_set2(GLOBAL{myVarC})
	
	dk_set2(myVarA "Value of myVarA (LOCAL)")
	dk_set2(myVarA)

	dk_set2(myVarB "Value of myVarB (LOCAL)")
	dk_set2(myVarB)
	
	dk_set2(myVarC "Value of myVarC (LOCAL)")
	dk_set2(myVarC)
#	unset(myVarA)
#	dk_set2(myVarA)
#	unset(myVarB)
#	dk_set2(myVarB)
#	unset(myVarC)
#	dk_set2(myVarC)
	
	
	dk_set2(CACHE{myVarA} "NEW Value of myVarA (CACHE)")
	dk_set2(CACHE{myVarA})
	
	dk_set2(CACHE{myVarB} "NEW Value of myVarB (CACHE)")
	dk_set2(CACHE{myVarB})
	
	dk_set2(CACHE{myVarC} "NEW Value of myVarC (CACHE)")
	dk_set2(CACHE{myVarC})
	
	
endfunction()


message("####################################################")
message("")
DKTEST()
message("")
message("####################################################")
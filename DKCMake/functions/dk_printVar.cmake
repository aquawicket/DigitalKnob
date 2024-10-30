#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_printVar(variable)
#
#	If the msg is a defined variable, print it's name and value
#	@variable	- The name of the variable to print
#
function(dk_printVar)
	dk_debugFunc()

	string(REPLACE "ENV{" "" 	ARGV "${ARGV}")
	string(REPLACE "CACHE{" "" 	ARGV "${ARGV}")
	string(REPLACE "}" "" 		ARGV "${ARGV}")

	dk_echo("")
	
	###### ENV ######
	if(DEFINED "ENV{${ARGV}}")
		dk_isList(isList "$ENV{${ARGV}}")
		if(isList)
			dk_echo("${cyan}\$ENV{${ARGV}}${white} is a ENV LIST variable ${clr}")
			dk_echo("${cyan}\$ENV{${ARGV}} = ${blue}'$ENV{${ARGV}}'${clr}")
		else()
			dk_echo("${cyan}\$ENV{${ARGV}}${white} is a ENV STRING variable${clr}")
			dk_echo("${cyan}\$ENV{${ARGV}} = ${blue}'$ENV{${ARGV}}'${clr}")
		endif()
	endif()	
		
	###### CACHE ######
	if(DEFINED "CACHE{${ARGV}}")
		dk_isList(isList "$CACHE{${ARGV}}")
		if(isList)
			dk_echo("${cyan}\$CACHE{${ARGV}}${white} is a CACHE LIST variable${clr}")
			dk_echo("${cyan}\$CACHE{${ARGV}} = ${blue}'$CACHE{${ARGV}}'${clr}")
		else()
			dk_echo("${cyan}\$CACHE{${ARGV}}${white} is a CACHE STRING variable${clr}")
			dk_echo("${cyan}\$CACHE{${ARGV}} = ${blue}'$CACHE{${ARGV}}'${clr}")
		endif()
	endif()
		
	###### LOCAL ######
	if(DEFINED "${ARGV}")
		dk_isList(isList "${ARGV}")
		if(isList)
			dk_echo("${cyan}\${${ARGV}}${white} is a LOCAL LIST variable${clr}")
			dk_echo("${cyan}\${${ARGV}} = ${blue}'${${ARGV}}'${clr}")
		else()
			dk_echo("${cyan}\${${ARGV}}${white} is a LOCAL STRING variable${clr}")
			dk_echo("${cyan}\${${ARGV}} = ${blue}'${${ARGV}}'${clr}")
		endif()	
	endif()	
		
	###### MACRO ######
	dk_isMacro(isMacro "${ARGV}")
	if(isMacro)
		dk_echo("${cyan}${ARGV}()${white} is a MACRO${clr}")
	endif()
	
	###### FUNCTION ######
	dk_isFunction(isFunction "${ARGV}")
	if(isFunction)
		dk_echo("${cyan}${ARGV}()${white} is a FUNCTION${clr}")
	endif()		
		

#	if(DEFINED "${${ARGV}}")
#		dk_echo("${cyan}${ARGV} = ${blue}${${ARGV}} = '${${${ARGV}}}'${clr}")
#	endif()
#	if(DEFINED "${${${ARGV}}}")
#		dk_echo("${cyan}${ARGV} = ${blue}${${ARGV}} = ${${${ARGV}}} = '${${${${ARGV}}}}'${clr}")
#	endif()
#	if(DEFINED "${${${${ARGV}}}}")
#		dk_echo("${cyan}${ARGV} = ${blue}${${ARGV}} = ${${${ARGV}}} = ${${${${ARGV}}}} = '${${${${${ARGV}}}}}'${clr}")
#	endif()
			
	if((NOT DEFINED "${ARGV}") AND (NOT DEFINED "ENV{${ARGV}}") AND (NOT DEFINED "CACHE{${ARGV}}") AND (NOT isFunction) AND (NOT isMacro))
		dk_echo("${cyan}${ARGV}${red} is UNDEFINED${clr}")
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	###### UNDEFINED ######
	dk_printVar(myUndefined)
	
	
	###### ENV STRING ######
	set(ENV{myEnv} "myEnv")
	dk_printVar(myEnv)
	
	
	###### ENV LIST ######
	set(ENV{myEnvList} "myEnvList 0")
	set(ENV{myEnvList} "$ENV{myEnvList};")
	set(ENV{myEnvList} "$ENV{myEnvList};myEnvList 2")
	dk_printVar(myEnvList)
	
	
	###### CACHE STRING ######
	set(myCache "myCache" CACHE INTERNAL "")
	dk_printVar(myCache)
	
	
	###### CACHE LIST ######
	set(myCacheList "myCacheList 0" CACHE INTERNAL "")
	set(myCacheList "${myCacheList};" CACHE INTERNAL "")
	set(myCacheList "${myCacheList};myCacheList 2" CACHE INTERNAL "")
	dk_printVar(myCacheList)


	###### LOCAL STRING ######
	set(myLocal "myLocal")
	dk_printVar(myLocal)
	
	
	###### LOCAL LIST ######
	set(myLocalList "myLocalList 0")
	list(APPEND myLocalList "")
	list(APPEND myLocalList "myLocalList 2")
	dk_printVar(myLocalList)


	###### MACRO ######
	macro(myMacro)
		dk_echo("myMacro body")
	endmacro()
	dk_printVar(myMacro)
	
	
	###### FUNCTION ######
	function(myFunction)
		dk_echo("myFunction body")
	endfunction()
	dk_printVar(myFunction)
	
	
	###### EVERYTHING ######
	set(myALL_ENV "myALL_ENV 0")
	list(APPEND myALL_ENV "myALL_ENV 1")
	list(APPEND myALL_ENV "")
	list(APPEND myALL_ENV "myALL_ENV 3")
	set(ENV{myALL} "${myALL_ENV}")
	
	set(myALL_CACHE "myALL_CACHE 0")
	list(APPEND myALL_CACHE "myALL_CACHE 1")
	list(APPEND myALL_CACHE "")
	list(APPEND myALL_CACHE "myALL_CACHE 3")
	set(myALL "${myALL_CACHE}" CACHE INTERNAL "")
	
	set(myALL "myALL_LOCAL A")
	list(APPEND myALL_LOCAL "myALL_LOCAL B")
	list(APPEND myALL_LOCAL "")
	list(APPEND myALL_LOCAL "myALL_LOCAL D")
	set(myALL "${myALL_LOCAL}")
	
	macro(myALL)
		dk_echo("myALL macro body")
	endmacro()
	
	function(myALL)
		dk_echo("myALL function body")
	endfunction()
	
	dk_printVar(myALL)
endfunction()

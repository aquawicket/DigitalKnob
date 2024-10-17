#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_printVar(variable)
#
#	If the msg is a defined variable, print it's name and value
#	@var	- The variable name to print
#
function(dk_printVar var)
	dk_debugFunc()

	if("${var}" MATCHES "ENV{") # ENV variables
		set(ENV_VAR ${var})
		dk_replaceAll("${ENV_VAR}"  "ENV{"  ""  ENV_VAR)
		dk_replaceAll("${ENV_VAR}"  "}"  ""  ENV_VAR)
		
		dk_convertToCIdentifier(${ENV_VAR} alphanum_var)
		if(NOT "${ENV_VAR}" STREQUAL "${alphanum_var}")
			dk_error("${ENV_VAR} is not a valid variable name. It contains invalid characters.")
		endif()
	
		dk_echo("${cyan}ENV:${var} = ${blue}'$ENV{${ENV_VAR}}'${clr}")
		
	else()	# regular variables
		dk_convertToCIdentifier(${var} alphanum_var)
		if(NOT "${var}" STREQUAL "${alphanum_var}")
			dk_error("${var} is not a valid variable name. It contains invalid characters.")
		endif()
		
		if(DEFINED "${${${${var}}}}")
			dk_echo("${cyan}POINTER:${var} = ${blue}${${var}} = ${${${var}}} = ${${${${var}}}} = '${${${${${var}}}}}'${clr}")
		elseif(DEFINED "${${${var}}}")
			dk_echo("${cyan}POINTER:${var} = ${blue}${${var}} = ${${${var}}} = '${${${${var}}}}'${clr}")
		elseif(DEFINED "${${var}}")
			dk_echo("${cyan}POINTER:${var} = ${blue}${${var}} = '${${${var}}}'${clr}")
		elseif(DEFINED "${var}")
			#dk_isList(isList ${var})  # TODO
			if(isList)
				dk_echo("${cyan}LIST:${var} = ${blue}'${${var}}'${clr}")
			else()
				dk_echo("${cyan}VARIABLE:${var} = ${blue}'${${var}}'${clr}")
			endif()
		else()
			dk_echo("${cyan}${var} = ${red}UNDEFINED${clr}")
		endif()
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	set(myVariable "this is the value of myVariable")
	dk_printVar(myVariable)
	
	set(myList "")
	list(APPEND myList "myList element 1")
	list(APPEND myList "myList element 1")
	list(APPEND myList "myList element 2")
	dk_printVar(myList)
	
	function(myFunction)
		dk_echo("myFunction body")
	endfunction(myFunction)
	dk_printVar(myFunction)
	
	# myUndefined  :this variable is undefined
	dk_printVar(myUndefined)

#	myArray[0]="myArray element 0"
#	myArray[1]="myArray element 1"
#	myArray[2]="myArray element 2"
#	dk_printVar(myArray)
	
#	export myExport="an export variable"
#	dk_printVar(myExport)
	
#	local myLocal="a local variable"
#	dk_printVar(myLocal)
	
#	declare -A myHash=( ["indexA"]="this is indexA" ["indexB"]="this is indexB")
#	dk_printVar(myHash)
	
#	alias myAlias='{
#		echo "This is an alias"
#	}'
#	dk_printVar myAlias
	
endfunction()

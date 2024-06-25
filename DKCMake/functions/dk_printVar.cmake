include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_printVar(variable)
#
#	If the msg is a defined variable, print it's name and value
#	@var	- The variable name to print
#
function(dk_printVar var)
	dk_debugFunc(${ARGV})
	
	if(DEFINED "${var}")
		if("${var}" MATCHES "ENV{") # ENV variables
			set(ENV_VAR ${var})
			dk_replaceAll("${ENV_VAR}"  "ENV{"  ""  ENV_VAR)
			dk_replaceAll("${ENV_VAR}"  "}"  ""  ENV_VAR)
			message("${cyan}${var} = ${blue}'$ENV{${ENV_VAR}}'${clr}")
		else()	# regular variables
			if(DEFINED "${${${${var}}}}")
				message("${cyan}${var} = ${blue}${${var}} = ${${${var}}} = ${${${${var}}}} = '${${${${${var}}}}}'${clr}")
			elseif(DEFINED "${${${var}}}")
				message("${cyan}${var} = ${blue}${${var}} = ${${${var}}} = '${${${${var}}}}'${clr}")
			elseif(DEFINED "${${var}}")
				message("${cyan}${var} = ${blue}${${var}} = '${${${var}}}'${clr}")
			else()
				message("${cyan}${var} = ${blue}'${${var}}'${clr}")
			endif()
		endif()
	else()  # Undefined
		message("${cyan}${var} = ${red}UNDEFINED${clr}")
		return()
	endif()
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	set(myVariable "this is the value of myVariable")
	dk_printVar(myVariable)
	
	set(myList "")
	list(APPEND myList "myList element 1")
	list(APPEND myList "myList element 1")
	list(APPEND myList "myList element 2")
	dk_printVar(myList)
	
	function(myFunction)
		message("myFunction body")
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

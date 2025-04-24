#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

##################################################################################
# dk_varToString(variable string)
#
function(dk_varToString var str)
	dk_debugFunc()

	set(tmp ${var})
	string(APPEND var_str "{${tmp}}")
	
	while(${${tmp}})
		set(tmp ${${tmp}})
		string(APPEND var_str ":{${tmp}}")
	endwhile()
	
	string(APPEND var_str " = ${${tmp}}")
	
	set(${str} "${var_str}" PARENT_SCOPE)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	set(varC "string value")
	dk_varToString(varC varC_str)
	dk_echo("${varC_str}")
	
	set(varB varC)
	dk_varToString(varB varB_str)
	dk_echo("${varB_str}")
	
	set(varA varB)
	dk_varToString(varA varA_str)
	dk_echo("${varA_str}")
endfunction()

#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##############################################################################
# dk_isMacro(rtn_var macro_name)
# 
#	Test if a string is a macro
#
#	@macro_name	- The macro_name to test
#	@rtn_var: 	- True if the string is the name of a macro, False if otherwise.
#
function(dk_isMacro rtn_var)
	dk_debugFunc()
	
	set(${rtn_var} 0 PARENT_SCOPE)
	if(COMMAND "${ARGN}")
		get_directory_property(macros MACROS)
		if(${ARGN} IN_LIST macros)
			set(${rtn_var} 1 PARENT_SCOPE)
		endif()
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
macro(test_macro)
	dk_echo("test_macro body")
endmacro()

function(DKTEST)
	dk_debugFunc()
	
	dk_isMacro(isMacro "test_macro")
	if(isMacro)
		dk_echo("'test_macro' is a macro")
	else()
		dk_echo("'test_macro' is NOT a macro")
	endif()
	
	dk_isMacro(isMacro "nonExistentMacro")
	if(isMacro)
		dk_echo("'nonExistentMacro' is a macro")
	else()
		dk_echo("'nonExistentMacro' is NOT a macro")
	endif()
endfunction()

#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

##############################################################################
# dk_isMacro(arg)
# 
#	Test if (arg) is a macro
#
#	@arg		 	- The argument to test
#	@dk_isMacro: 	- 1 if arg is a macro, 0 if otherwise.
#
function(dk_isMacro)
	dk_debugFunc()
	
	dk_getArg(0 _arg0_)
	
	if(COMMAND "${_arg0_}")
		get_directory_property(macros MACROS)
		if(${_arg0_} IN_LIST macros)
			set(dk_isMacro 1 PARENT_SCOPE)
		else()
			set(dk_isMacro 0 PARENT_SCOPE)
		endif()
	else()
		set(dk_isMacro 0 PARENT_SCOPE)
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
macro(test_macro)
	dk_echo("test_macro body")
endmacro()

function(DKTEST)
	dk_debugFunc(0)
	
	dk_isMacro("test_macro")
	if(dk_isMacro)
		dk_echo("'test_macro' is a macro")
	else()
		dk_echo("'test_macro' is NOT a macro")
	endif()
	
	dk_isMacro("nonExistentMacro")
	if(dk_isMacro)
		dk_echo("'nonExistentMacro' is a macro")
	else()
		dk_echo("'nonExistentMacro' is NOT a macro")
	endif()
endfunction()

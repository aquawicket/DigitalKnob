#!/usr/bin/cmake -P
<<<<<<< HEAD
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
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
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
>>>>>>> Development
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
macro(test_macro)
	dk_echo("test_macro body")
endmacro()

function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_isMacro(isMacro "test_macro")
	if(isMacro)
=======
	dk_debugFunc(0)
	
	dk_isMacro("test_macro")
	if(dk_isMacro)
>>>>>>> Development
		dk_echo("'test_macro' is a macro")
	else()
		dk_echo("'test_macro' is NOT a macro")
	endif()
	
<<<<<<< HEAD
	dk_isMacro(isMacro "nonExistentMacro")
	if(isMacro)
=======
	dk_isMacro("nonExistentMacro")
	if(dk_isMacro)
>>>>>>> Development
		dk_echo("'nonExistentMacro' is a macro")
	else()
		dk_echo("'nonExistentMacro' is NOT a macro")
	endif()
endfunction()

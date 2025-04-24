#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##############################################################################
# dk_getArg(arg_num, var_name, default)
#
#	Get a variable within a function by its position.
#   If the variable points to another variable, it will be expanded until the 
#   final pointed to value is found. If the variable is non existent, the default
#	value will be used
#
#	Example:  
#
#	myFunction(123, abc)
#
#	function(myFunction)
#		
#		dk_getArg(0 MyFirstArg "XXX")    # MyFirstArg = '123'
#		dk_getArg(1 MySecondArg "YYY")	 # MySecondArg = 'abc'
#		dk_getArg(2 MyThirdArg "ZZZ")	 # MyThirdArg = 'ZZZ'
#
#	endfunction()
#
macro(dk_getArg arg_num)
	set(lvl 0)
	set(value ARGV${arg_num})
	while(DEFINED "${value}")
		set(name "${name}-> ${value}")
		set(value ${${value}})
		math(EXPR lvl "${lvl} + 1")
	endwhile()

#	dk_debug("lvl = ${lvl}")
#	dk_debug("name = ${name}")
	if(NOT ${lvl})
#		dk_debug("default = ${ARGV2}")
		set(${ARGV1} ${ARGV2})
	else()
#		dk_debug("value = ${value}")
		set(${ARGV1} ${value})
	endif()
endmacro()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	test_getArg(abc "123" rtn_var)
endfunction()

function(test_getArg)
	dk_getArg(0 arg0 "default0")
	dk_getArg(1 arg1 "default2")
	dk_getArg(2 arg2 "default2")
	
	dk_info("arg0 = ${arg0}")
	dk_info("arg1 = ${arg1}")
	dk_info("arg2 = ${arg2}")
endfunction()
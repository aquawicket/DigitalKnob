#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
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
macro(dk_getArg arg_num)
#	message("dk_getArg(${ARGV})")
	set(lvl 0)
	if("${arg_num}" STREQUAL "all")
		set(value ${ARGV})
	else()
		set(value ARGV${arg_num})
	endif()
	while(DEFINED "${value}")
		set(name "${name}-> ${value}")
		set(value ${${value}})
		math(EXPR lvl "${lvl} + 1")
	endwhile()

#	message("lvl = ${lvl}")
#	message("name = ${name}")
	if(NOT ${lvl})
#		message("default = ${ARGV2}")
		set(${ARGV1} ${ARGV2})
	else()
#		message("value = ${value}")
		set(${ARGV1} ${value})
	endif()
endmacro()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
endfunction()

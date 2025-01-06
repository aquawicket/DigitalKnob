#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

##############################################################################
# dk_getArg(ARGV(N) toName Default)
# 
#
macro(dk_getArg)
	set(lvl 0)
	set(value ARGV0)
	set(default ${ARGV1})
	while(DEFINED "${value}")
		set(name "${name}-> ${value}")
		set(value ${${value}})
		math(EXPR lvl "${lvl} + 1")
	endwhile()

	message("lvl = ${lvl}")
	message("name = ${name}")

	if(NOT ${lvl})
		message("default = ${default}")
		set(${ARGV0} ${default})
	else()
		message("value = ${value}")
		set(${ARGV1} ${value})
	endif()
endmacro()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
endfunction()

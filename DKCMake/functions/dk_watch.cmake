include_guard()

dk_load(dk_watchCallback)
##############################################################################
# dk_watch(variable)
# 
#	Watch a varible reading and writing access events
#
#	@variable	- The variable to watch
#
macro(dk_watch variable)
	DKDEBUGFUNC(${ARGV})
	variable_watch(variable dk_watchCallback)
endmacro()

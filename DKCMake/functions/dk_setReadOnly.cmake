include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_setReadOnly(VAR)
#
#	TODO
#
#	@VAR	- TODO
#	 
macro(dk_setReadOnly VAR)
	dk_debugFunc(${ARGV})
	
	set("${VAR}" "${ARGN}")						# Set the variable itself
	set("_${VAR}_readonly_val" "${ARGN}")		# Store the variable's value for restore it upon modifications.
	variable_watch("${VAR}" dk_readOnlyCallback)	# Register a watcher for a variable
endmacro()






function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)
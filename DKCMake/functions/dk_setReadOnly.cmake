include_guard()

###############################################################################
# dk_setReadOnly(VAR)
#
#	TODO
#
#	@VAR	- TODO
#	 
macro(dk_setReadOnly VAR)
	DKDEBUGFUNC(${ARGV})
	set("${VAR}" "${ARGN}")						# Set the variable itself
	set("_${VAR}_readonly_val" "${ARGN}")		# Store the variable's value for restore it upon modifications.
	variable_watch("${VAR}" dk_readOnlyCallback)	# Register a watcher for a variable
endmacro()
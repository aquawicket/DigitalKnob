include_guard()

###############################################################################
# dk_validatePath(path RESULT)
#
#	TODO
#
#	@path		- TODO
#	@RESULT		- TODO
#
function(dk_validatePath path RESULT)
	DKDEBUGFUNC(${ARGV})
	get_filename_component(path ${path} ABSOLUTE)
	set(${RESULT} ${path} PARENT_SCOPE)
endfunction()
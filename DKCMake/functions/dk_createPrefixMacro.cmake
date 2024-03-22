include_guard()
dk_load(DKDEBUGFUNC)

###############################################################################
# dk_createPrefixMacro(func prefix_list)
#
#	Prefix a function with <prefix_list>_ macros. Calling the <prefix>_function will only be called if the <prefix_list> are variable that evaluate to true.
#
#	@prefix	- The prefix to prepend to the function name.    I.E.    Test_MyFunction()
#	@func	- The func of the function to create aliases for
#
function(dk_createPrefixMacro func) #ARGN
	DKDEBUGFUNC(${ARGV})
	set(${ARGN})
	string(REPLACE ";" "_" prefix_name "${ARGN}")
	string(REPLACE ";" " AND " prefix_if "${ARGN}")
	set(MACRO_STRING "macro(${prefix_name}_${func})\n   if(${prefix_if})\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	#message("MACRO_STRING = ${MACRO_STRING}")
	dk_eval(${MACRO_STRING})
endfunction()
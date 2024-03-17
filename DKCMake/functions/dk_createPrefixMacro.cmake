include_guard()

###############################################################################
# dk_createPrefixMacro(prefix func)
#
#	Prefix a function with <prefix>_ macros. Calling the <prefix>_function will only be called if the <prefix> is a variable set to true
#
#	@prefix	- The prefix to prepend to the function name.    I.E.    Test_MyFunction()
#	@func	- The func of the function to create aliases for
#
function(dk_createPrefixMacro prefix func)
	dk_eval("macro(${prefix}_${func})\n   if(${prefix})\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
endfunction()
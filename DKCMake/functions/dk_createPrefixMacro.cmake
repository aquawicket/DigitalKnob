include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()
dk_load(dk_eval)
dk_load(dk_debugFunc)


###############################################################################
# dk_createPrefixMacro(func prefix_list)
#
#	Prefix a function with <prefix_list>_ macros. Calling the <prefix>_function will only be called if the <prefix_list> are variable that evaluate to true.
#
#	@prefix	- The prefix to prepend to the function name.    I.E.    Test_MyFunction()
#	@func	- The func of the function to create aliases for
#
function(dk_createPrefixMacro func) #ARGN
	dk_debugFunc(${ARGV})
	
	set(${ARGN})
	dk_replaceAll("${ARGN}"  ";"  "_"  prefix_name)
	dk_replaceAll("${ARGN}"  ";"  " AND "  prefix_if)
	set(MACRO_STRING "macro(${prefix_name}_${func})\n   if(${prefix_if})\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	#dk_printVar(MACRO_STRING)
	dk_eval(${MACRO_STRING})
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)
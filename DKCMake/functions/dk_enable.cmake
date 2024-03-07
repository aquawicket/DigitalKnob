include_guard()

###############################################################################
# dk_enable(plugin)
#
#	TODO
#
#	@plugin		- TODO
#
function(dk_enable plugin)
	DKDEBUGFUNC(${ARGV})
	if(NOT ${plugin})
		if(${ARGC} GREATER 1)
			dk_set(${${ARGV1}} ON)
			dk_set(HAVE_${${ARGV1}} ON)
			# In c/c++ we can't use certian symbals in the preprocess or for macros. I.E. - must be turned to _
			string(MAKE_C_IDENTIFIER ${ARGV1} argv1_macro)
			dk_define(HAVE_${argv1_macro})
		else()
			dk_set(${plugin} ON)
			dk_set(HAVE_${plugin} ON)
			# In c/c++ we can't use certian symbals in the preprocess or for macros. I.E. - must be turned to _
			string(MAKE_C_IDENTIFIER ${plugin} plugin_macro)
			dk_define(HAVE_${plugin_macro})
		endif()
	endif()
endfunction()

include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_require(plugin)
#
#	Require a plugin, return if plugin unavailable
#
#	@plugin				- TODO
#	@target (optional)	- TODO
#
# FIXME
macro(dk_require plugin)
	list(FIND dk_disabled_list ${plugin} index)
	if(${index} GREATER -1)
		dk_getBasename(${CMAKE_CURRENT_LIST_DIR} Lib)
		dk_notice("${Lib} requires ${plugin} which is DISABLED")
		dk_notice("DISABLING ${Lib}")
		dk_disable(${Lib})
		return()
	endif()
	dk_depend(${plugin})
endmacro()





function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)
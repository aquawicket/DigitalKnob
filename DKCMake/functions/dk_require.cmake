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
		get_filename_component(Lib ${CMAKE_CURRENT_LIST_DIR} NAME)
		dk_notice("${Lib} requires ${plugin} which is DISABLED")
		dk_notice("DISABLING ${Lib}")
		dk_disable(${Lib})
		return()
	endif()
	dk_depend(${plugin})
endmacro()
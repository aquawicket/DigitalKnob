include_guard()

###############################################################################
# dk_undepend(plugin)
#
#	Remove a library or plugin from the dependency list
#
#	@plugin				- TODO
#	@target (optional)	- TODO
#
function(dk_undepend plugin)
	DKDEBUGFUNC(${ARGV})
	set(target ${ARGV1})
	
	# Only allow dk_undepend command from these filters	
	if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKCMAKE_DIR})
		if(DK_PROJECT_DIR)
			if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DK_PROJECT_DIR})
				if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKIMPORTS_DIR}/${plugin})
					if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKPLUGINS_DIR}/${plugin})
						dk_error("dk_undepend() Can only be used from a plugin directory. This is to avoid having disabled libraries hideing everywhere")
					endif()
				endif()
			endif()
		endif()
	endif()
	
	#dk_dump(plugin)
	# remove from ${dkdepend_list}
	list(FIND dkdepend_list ${plugin} index)
	if(${index} GREATER -1)
		# is was found, now remove
		list(REMOVE_ITEM dkdepend_list ${plugin})
	endif()
	
	dk_info("DISABLING ${ARGV}")
	dk_set(dk_disabled_list ${dk_disabled_list} "${ARGV}")
	if(${ARGC} GREATER 1)
		dk_removeTarget(${plugin} ${ARGV1})
	endif()	   
endfunction()
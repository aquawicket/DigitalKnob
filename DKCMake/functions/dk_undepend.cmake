include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_undepend(plugin)
#
#	Remove a library or plugin from the dependency list
#
#	@plugin				- TODO
#	@target (optional)	- TODO
#
function(dk_undepend plugin)
	dk_debugFunc(${ARGV})
	
	set(target ${ARGV1})
	
	# Only allow dk_undepend command from these filters	
#	if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKCMAKE_DIR})
#		if(DK_PROJECT_DIR)
#			if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DK_PROJECT_DIR})
#				if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKIMPORTS_DIR}/${plugin})
#					if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKPLUGINS_DIR}/${plugin})
#						dk_fatal("dk_undepend() Can only be used from a plugin directory. This is to avoid having disabled libraries hideing everywhere")
#					endif()
#				endif()
#			endif()
#		endif()
#	endif()
	
	# remove from ${dkdepend_list}
	#list(FIND dkdepend_list ${plugin} index)
	#if(${index} GREATER -1)
	if(plugin IN_LIST dkdepend_list)
		list(REMOVE_ITEM dkdepend_list ${plugin}) # it was found, now remove
	endif()
	
	dk_info("DISABLING ${ARGV}")
	dk_append(dk_disabled_list "${ARGV}")
	
	if(${ARGC} GREATER 1)
		dk_removeTarget(${plugin} ${ARGV1})
	endif()	   
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()
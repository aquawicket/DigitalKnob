#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
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
	dk_debugFunc()
	
	set(target ${ARGV1})
	
	# Only allow dk_undepend command from these filters	
#	if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL $ENV{DKCMAKE_DIR})
#		if(Target_App_Dir)
#			if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${Target_App_Dir})
#				if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL $ENV{DKIMPORTS_DIR}/${plugin})
#					if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKCPP_PLUGINS_DIR}/${plugin})
#						dk_fatal("dk_undepend() Can only be used from a plugin directory. This is to avoid having disabled libraries hideing everywhere")
#					endif()
#				endif()
#			endif()
#		endif()
#	endif()
	
	# remove from ${dkdepend_list}
	if(plugin IN_LIST dkdepend_list)
		list(REMOVE_ITEM dkdepend_list ${plugin}) # it was found, now remove
		dk_set(dkdepend_list ${dkdepend_list})
#		dk_printVar(dkdepend_list)
	endif()
	
	dk_notice("DISABLING ${ARGV}")
	dk_append(dk_disabled_list "${ARGV}")
	dk_set(dk_disabled_list ${dk_disabled_list})
#	dk_printVar(dk_disabled_list)
	
	if(${ARGC} GREATER 1)
		dk_removeTarget(${plugin} ${ARGV1})
	endif()	   
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()
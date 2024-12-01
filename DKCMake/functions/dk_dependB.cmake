#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()


###############################################################################
# dk_dependB(plugin)
#
#	Add a library or plugin to the dependency list
#
#	@plugin		- TODO
#
function(dk_dependB plugin)
	dk_debugFunc()
	
	if(CMAKE_SCRIPT_MODE_FILE OR NOT DKAPP)
		if(plugin IN_LIST init_list)
			#dk_debug("${plugin} is allready in init_list")
			return()  #plugin is already in the init_list
		endif()
		dk_append(init_list "${plugin}")
		
		dk_getPathToPlugin(${plugin} plugin_path)
		dk_load(${plugin_path}/DKMAKE.cmake)
		#return()
	endif()
	
#	if(${ARGC} GREATER 1)
#		dk_info(ARGV)
#		dk_dump(ARGV) # FIXME: DUMP not working here, show 2 for the ARGC count, but only shows variable plugin ARGV, no value
#	endif()

	if(plugin IN_LIST dk_disabled_list)
		if(DISABLED_LIBS MATCHES "${plugin}")
			dk_append(DISABLED_LIBS "${plugin}") # this list is for the build.log
		endif()
		dk_notice("${plugin} IS DISABLED")
		return()
	endif()
	
# 	TODO TODO TODO TODO 
# 	dk_createSmartObject(${plugin}) #TODO:  automatically determin plugin, create variables, setup auto compiles, etc 
# 	TODO TODO TODO TODO 
	
#	If dk_depend had second variable (a sub library), set that variable to ON
#	if(${ARGC} GREATER 1)
#	if(dkdepend_list MATCHES "${plugin} ${args}")
#		return()  #library is already in the list
#	endif()
#	else()
#		if(dkdepend_list MATCHES "${plugin}")
#			return() #library is already in the list
#		endif()
#	endif()
		
	if(plugin IN_LIST dkdepend_list)
		#dk_verbose("${plugin} already in dkdepend_list")
		return()  #library is already in the list
	endif()
	
	dk_enable(${plugin})
	dk_runDepends(${plugin}) # strip everything from the file except if() else() elseif() endif() and dk_depend() before sorting.
#	else()
#		if(dkdepend_list MATCHES "${plugin}")
#			return() #library is already in the list
#		endif()
#		dk_runDepends(${plugin}) # strip everything from the file except if() else() elseif() endif() and dk_depend() before sorting.
#	endif()
endfunction()
dk_createOsMacros("dk_depend")






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_dependB(todo)
endfunction()
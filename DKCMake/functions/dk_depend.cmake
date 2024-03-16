include_guard()

###############################################################################
# dk_depend(plugin)
#
#	Add a library or plugin to the dependency list
#
#	@plugin		- TODO
#
function(dk_depend plugin)
	DKDEBUGFUNC(${ARGV})
	
	if(CMAKE_SCRIPT_MODE_FILE OR NOT DKAPP)
		list(FIND init_list ${plugin} index)
		if(${index} GREATER -1)
			#dk_debug("${plugin} is allready in the init_list")
			return()  #plugin is already in the init_list
		endif()
		#dk_set(init_list ${init_list} "${plugin}")
		list(APPEND init_list "${plugin}")
		
		dk_getPathToPlugin(${plugin} plugin_path)
		include(${plugin_path}/DKMAKE.cmake)
		#return()
	endif()
	
	
#	if(${ARGC} GREATER 1)
#		dk_info(ARGV)
#		dk_dump(ARGV) # FIXME: DUMP not working here, show 2 for the ARGC count, but only shows variable plugin ARGV, no value
#	endif()

	list(FIND dk_disabled_list ${plugin} index)
	if(${index} GREATER -1)
		list(FIND DISABLED_LIBS ${plugin} indexb)
		if(${indexb} LESS 0)
			dk_set(DISABLED_LIBS ${DISABLED_LIBS} "${plugin}") #this list is for the build.log
		endif()
		dk_warn("${plugin} IS DISABLED")
		return()
	endif()
	
# 	TODO TODO TODO TODO 
# 	dk_createSmartObject(${plugin}) #TODO:  automatically determin plugin, create variables, setup auto compiles, etc 
# 	TODO TODO TODO TODO 
	
#	If dk_depend had second variable (a sub library), set that variable to ON
#	if(${ARGC} GREATER 1)
#	list(FIND dkdepend_list "${plugin} ${args}" index)
#	if(${index} GREATER -1) #library is already in the list
#		return()
#	endif()
#	else()
#		list(FIND dkdepend_list "${plugin}" index)
#		if(${index} GREATER -1)
#			return() #library is already in the list
#		endif()
#	endif()
		
	list(FIND dkdepend_list ${plugin} index)
	if(${index} GREATER -1)
		return()  #library is already in the list
	endif()
	
	dk_enable(${plugin})
	dk_runDepends(${plugin}) # strip everything from the file except if() else() elseif() endif() and dk_depend() before sorting.
#	else()
#		list(FIND dkdepend_list "${plugin}" index)
#		if(${index} GREATER -1)
#			return() #library is already in the list
#		endif()
#		dk_runDepends(${plugin}) # strip everything from the file except if() else() elseif() endif() and dk_depend() before sorting.
#	endif()
endfunction()
dk_createOsMacros("dk_depend")
#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_runDepends(plugin)
#
#	Strip everything from the library's DKMAKE.cmake file except dk_depend() commands AND conditionals.
#	Conditionals and flow control statements such as if(), else(), elseif(), endif(), return() will remain included during the sorting process. 
#	WARNING: BE CAREFULL WRITING NEW VARIABLES TO USE WITH CONDITIONALS, AS THEY MIGHT BE IGNORED 
#
#	@plugin		- TODO
#
function(dk_runDepends plugin)
	dk_debugFunc()
	
	dk_getPathToPlugin(${plugin} plugin_path)
	if(NOT plugin_path)
		dk_fatal("${plugin} plugin not found")
	endif()
	dk_verbose("FOUND ${plugin} DKMAKE.cmake at ${plugin_path}")
	
	file(STRINGS ${plugin_path}/DKMAKE.cmake lines)
	dk_unset(disable_script)
	dk_unset(depends_script)
	dk_unset(index)
	
	set(keepCommands "if;else;dk_depend")
	set(KEEPLINE 0)
	foreach(line ${lines})
	
		foreach(keepCommand ${keepCommands})
			if(line MATCHES "${keepCommand}\\(") # <function>(
				set(KEEPLINE 1)
			endif()
			if(line MATCHES "${keepCommand} ") # <function> space
				set(KEEPLINE 1)
			endif()
			 if(line MATCHES "${keepCommand}	") # <function> tab
				set(KEEPLINE 1)
			endif()
		endforeach()
		
		# FIXME: THIS iS UNTESTED! This will remove any lines that contain a #
		#if(line MATCHES "#")
		#	set(KEEPLINE 0)
		#endif()
		
		if(KEEPLINE)
			set(depends_script "${depends_script}${line}\n")
		endif()
		
		# FIXME: we need to get a proper count of openeing (  before we can determine that we have actually reached the closing )
		if(line MATCHES "\\)")
			set(KEEPLINE 0)
		endif()
	endforeach()
	
	if(depends_script)
		if(${ARGC} GREATER 1)
			dk_enable(${ARGV1})
		else()
			dk_set(${ARGV0}_all ON)
		endif()
		dk_fileWrite(${plugin_path}/DEPENDS.TMP "${depends_script}")
		include(${plugin_path}/DEPENDS.TMP)
		dk_delete(${plugin_path}/DEPENDS.TMP)
		if(${ARGC} GREATER 1)
			dk_set(${ARGV1} OFF)
		endif()
	endif()
	
	if("${ARGV}" IN_LIST dkdepend_list)
		dk_return()  # already in list
	endif()
	
	dk_append(dkdepend_list "${ARGV}")   # Add target to list
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_runDepends(plugin) #TODO
endfunction()
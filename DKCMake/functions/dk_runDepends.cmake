include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_runDepends(plugin)
#
#	Strip everything from the library's DKMAKE.cmake file except dk_depend() commands AND conditionals.
#	Conditionals such as if(), else(), elseif(), endif(), return() will remain included during the sorting process. 
#	WARNING: BE CAREFULL WRITING NEW VARIABLES TO USE WITH CONDITIONALS, AS THEY MIGHT BE IGNORED 
#
#	@plugin		- TODO
#
function(dk_runDepends plugin)
	dk_debugFunc("\${ARGV}")
	
	dk_getPathToPlugin(${plugin} plugin_path)
	if(NOT plugin_path)
		dk_fatal("${plugin} plugin not found")
	endif()
	dk_verbose("FOUND ${plugin} DKMAKE.cmake at ${plugin_path}")
	
	file(STRINGS ${plugin_path}/DKMAKE.cmake lines)
	dk_unset(disable_script)
	dk_unset(depends_script)
	dk_unset(index)
	
	
	#set(keepCommands "if;else;find_library;return;dk_disable;dk_set;dk_makeDirectory;dk_require;dk_undepend")
	#set(KEEPLINE 0)
	#foreach(line ${lines})
	#	
	#	foreach(keepCommand ${keepCommands})
	#		dk_includes("${line}" "${keepCommand}(" hasCommand) # trailing (
	#		if(${hasCommand})
	#			set(KEEPLINE 1)
	#		endif()
	#		dk_includes("${line}" "${keepCommand} " hasCommand) # trailing space
	#		if(${hasCommand})
	#			set(KEEPLINE 1)
	#		endif()
	#		dk_includes("${line}" "${keepCommand}	" hasCommand) # trailing tab
	#		if(${hasCommand})
	#			set(KEEPLINE 1)
	#		endif()
	#	endforeach()
	#	
	#	# FIXME: THIS iS UNTESTED! This will remove any lines that contain a #
	#	#dk_includes("${line}" "#" hasCommentSign)
	#	#if(${hasCommentSign})
	#	#	set(KEEPLINE 0)
	#	#endif()
	#	
	#	if(KEEPLINE)
	#		set(disable_script "${disable_script}${line}\n")
	#	endif()
	#	
	#	# FIXME: we need to get a proper count of openeing (  before we can determine that we have actually reached the closing )
	#	dk_includes("${line}" ")" includes)
	#	if(${includes})
	#		set(KEEPLINE 0)
	#	endif()
	#endforeach()
	
	#set(keepCommands "if;else;find_library;return;dk_enable;dk_disable;dk_depend;dk_set;message;dk_error;dk_warning;dk_info;dk_debug;dk_verbose;dk_makeDirectory;dk_require;dk_undepend")
	set(keepCommands "if;else;dk_depend")
	set(KEEPLINE 0)
	foreach(line ${lines})
	
		foreach(keepCommand ${keepCommands})
			dk_includes("${line}" "${keepCommand}(" hasCommand) # trailing (
			if(${hasCommand})
				set(KEEPLINE 1)
			endif()
			dk_includes("${line}" "${keepCommand} " hasCommand) # trailing space
			if(${hasCommand})
				set(KEEPLINE 1)
			endif()
			dk_includes("${line}" "${keepCommand}	" hasCommand) # trailing tab
			if(${hasCommand})
				set(KEEPLINE 1)
			endif()
		endforeach()
		
		# FIXME: THIS iS UNTESTED! This will remove any lines that contain a #
		#dk_includes("${line}" "#" hasCommentSign)
		#if(${hasCommentSign})
		#	set(KEEPLINE 0)
		#endif()
		
		if(KEEPLINE)
			set(depends_script "${depends_script}${line}\n")
		endif()
		
		# FIXME: we need to get a proper count of openeing (  before we can determine that we have actually reached the closing )
		dk_includes("${line}" ")" includes)
		if(${includes})
			set(KEEPLINE 0)
		endif()
	endforeach()
	
	#if(disable_script)
	#	dk_fileWrite(${plugin_path}/DISABLES.TMP "${disable_script}")
	#	INCLUDE(${plugin_path}/DISABLES.TMP)
	#	#dk_delete(${plugin_path}/DISABLES.TMP)
	#endif()
	
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
	
#	if(${ARGC} GREATER 1)
#		list(FIND dkdepend_list "${plugin} ${ARGV1}" index)
#		if(${index} GREATER -1)
#			return()
#		endif()
#	else()
#		list(FIND dkdepend_list "${plugin}" index)
#		if(${index} GREATER -1)
#			return() # already on the list
#		endif()
#	endif()
	if("${ARGV}" IN_LIST dkdepend_list)
		#dk_verbose("already in dkdepend_list")
		return()
	endif()
	
	dk_append(dkdepend_list "${ARGV}")   # Add target to list
#	if(${ARGC} GREATER 1)
#		dk_append(dkdepend_list "${plugin} ${ARGV1}")  #Add target to list
#	else()
#		dk_append(dkdepend_list ${plugin})  #Add library to list
#	endif()	
	#list(REMOVE_DUPLICATES dkdepend_list)
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()
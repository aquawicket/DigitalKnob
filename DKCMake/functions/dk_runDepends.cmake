#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# dk_runDepends(Plugin)
#
#	Strip everything from the library's DKINSTALL.cmake file except dk_depend() commands AND conditionals.
#	Conditionals and flow control statements such as if(), else(), elseif(), endif(), return() will remain included during the sorting process. 
#	WARNING: BE CAREFULL WRITING NEW VARIABLES TO USE WITH CONDITIONALS, AS THEY MIGHT BE IGNORED 
#
#	@Plugin		- TODO
#
function(dk_runDepends Plugin)
	dk_debugFunc()
	
	dk_getImportPath(${Plugin} PLUGIN_Import_Path)
	if(NOT PLUGIN_Import_Path)
		dk_fatal("${Plugin} Plugin NOT FOUND")
	endif()
	dk_verbose("FOUND ${Plugin} DKINSTALL.cmake at ${PLUGIN_Import_Path}")
	
	file(STRINGS ${PLUGIN_Import_Path}/DKINSTALL.cmake lines)
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
		dk_fileWrite(${PLUGIN_Import_Path}/DEPENDS.TMP "${depends_script}")
		#nclude(${PLUGIN_Import_Path}/DEPENDS.TMP)
		dk_load("${PLUGIN_Import_Path}/DEPENDS.TMP")
		dk_delete("${PLUGIN_Import_Path}/DEPENDS.TMP")
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
	
	dk_runDepends(Plugin) #TODO
endfunction()
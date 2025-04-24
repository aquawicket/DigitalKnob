#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_depend(plugin)
#
#	Add a library or plugin to the dependency list
#
#	@plugin		- TODO
#
function(dk_depend plugin)
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

=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()


###############################################################################
# dk_depend(plugin) target
#
#	Each plugin invoked will fill a a varaible or it's name to the path where it
#   is installed..   
#   I.E.  dk_depend(zlib) =  dk_validate(ZLIB "dk_dependB(zlib)") 
#   Which says, "if ZLIB variable is not set,  call  3rdParty/_DKIMPORTS/zlib/DKINSTALL.cmake
#   to fill fill ZLIB with the path zlib is installed to.
#
function(dk_depend plugin) #target
	dk_debugFunc(1 2)
	
>>>>>>> Development
	if(plugin IN_LIST dk_disabled_list)
		if(DISABLED_LIBS MATCHES "${plugin}")
			dk_append(DISABLED_LIBS "${plugin}") # this list is for the build.log
		endif()
<<<<<<< HEAD
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
=======
		#dk_notice("${plugin} IS DISABLED")
		return()
	endif()
	
	dk_toUpper("${plugin}" PLUGIN)
	dk_convertToCIdentifier(${PLUGIN} PLUGIN)
	set(${PLUGIN}_IMPORT_NAME ${plugin})
	if((NOT EXISTS ${PLUGIN}) OR (NOT EXISTS ${${PLUGIN}_DIR}))
		
		###### Push Plugin to the PLUGIN_STACK ######
		dk_envList(PLUGIN PUSH "${PLUGIN}")
		#############################################

		
		#dk_notice("dk_depend(): loading ${PLUGIN} . . .")
		dk_dependB(${plugin})
	
	
		###### Pop Plugin from the PLUGIN_STACK ######
		dk_envList(PLUGIN POP)
		#############################################
		
	else()
		dk_notice("dk_depend(): ${PLUGIN} is already loaded")
	endif()
endfunction()

>>>>>>> Development






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_todo()
=======
	dk_debugFunc(0)
	
	dk_depend(zlib)
>>>>>>> Development
endfunction()
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
# dk_depend(Plugin) target
#
#	Each Plugin invoked will fill a varaible of it's name to the path where it
#   is installed..   
#   I.E.  dk_validate(zlib "dk_depend(zlib)") 
#   Which says, "if 'zlib' variable is not set,  call  3rdParty/_DKIMPORTS/zlib/DKINSTALL.cmake
#   to fill 'zlib' with the path the zlib library is installed to.
#
function(dk_depend Plugin)
	if(DEFINED ${Plugin})
		message("### ${Plugin} already defined ###")
		return()
	endif()
	#dk_debug("############ dk_depend(${ARGV}) ############")
	dk_debugFunc(1 99)
	
	#set(Plugin "${ARGV0}")
	dk_allButFirstArgs(${ARGV})
	
	set(dkdepend_list $CACHE{dkdepend_list}) # Get the gloabl list
	#dk_debug("dkdepend_list = ${dkdepend_list}")
	
	if(Plugin IN_LIST dkdepend_list)
		dk_notice("Plugin:'${Plugin}' already added to dkdepend_list:'${dkdepend_list}'")
		#return()
	endif()
	
	if("${DISABLE_${Plugin}}" STREQUAL "1")
		dk_notice("Plugin:'${Plugin}' IS DISABLED")
		dk_pause()
		return()
	endif()	
	#if(Plugin IN_LIST dkdisabled_list)
	#	if(DISABLED_LIBS MATCHES "${Plugin}")
	#		dk_append(DISABLED_LIBS "${Plugin}") # this list is for the build.log
	#	endif()
	#	dk_notice("Plugin:'${Plugin}' IS DISABLED")
	#	return()
	#endif()

	#dk_delete("${${CURRENT_PLUGIN}_Build_Dir}/DKBUILD.log")
	
	###### Push Plugin to the PLUGIN_STACK ######
	dk_debug("ENV{PLUGIN_Stack} = $ENV{PLUGIN_Stack}")
	set(PLUGIN_Stack "$ENV{PLUGIN_Stack}")		### copy the env variable to local variable
	if(Plugin IN_LIST PLUGIN_Stack)
		dk_notice("Plugin:'${Plugin}' already in PLUGIN_Stack:'${PLUGIN_Stack}'")
		#return()
	endif()
	dk_envList(PLUGIN PUSH "${Plugin}")
	dk_debug("ENV{PLUGIN_Stack} = $ENV{PLUGIN_Stack}")
	
	dk_debug("\n")
	dk_debug("\n")
	dk_debug(">>>>>##############################################################################>>>>>")
	dk_debug(">>>>>########################### ${CURRENT_PLUGIN} ENTER ##########################>>>>>")
	dk_debug(">>>>>##############################################################################>>>>>")
		dk_title("${PLUGIN_Stack} ${Target_Tuple} ${Target_Type}")
	
		list(APPEND dkdepend_list "${CURRENT_PLUGIN}")
		dk_set(dkdepend_list "${dkdepend_list}") 									# Globalize the variable
		
		dk_getImportPath(${CURRENT_PLUGIN} ${CURRENT_PLUGIN}_Import_Path)
		dk_set(${CURRENT_PLUGIN}_Import_Path "${${CURRENT_PLUGIN}_Import_Path}")	# Globalize the variable

		dk_enable("${CURRENT_PLUGIN}")
		
		### Load the 'plugin'/DKINSTALL.cmake file
		#dk_importVariables(Import_Path "${Import_Path}")
		dk_load("${${CURRENT_PLUGIN}_Import_Path}/DKINSTALL.cmake") 				# Preload all of the dk_function in plugin/DKINSTALL.cmake
		include("${${CURRENT_PLUGIN}_Import_Path}/DKINSTALL.cmake") 				# Load plugin/DKINSTALL function

		### Run the DKINSTALL() function
		dk_fileIncludes("${${CURRENT_PLUGIN}_Import_Path}/DKINSTALL.cmake" "function(DKINSTALL")
		if(dk_fileIncludes)
			DKINSTALL(${dk_allButFirstArgs})
		endif()
		dk_debug("Plugin = ${Plugin} = ${${Plugin}}")
			
	###### Pop Plugin from the PLUGIN_STACK ######
	#dk_debug("<<<<<########################### ${CURRENT_PLUGIN} EXIT ###########################<<<<<\n")
	dk_envList(PLUGIN POP)
	dk_debug("\n")
	if(CURRENT_PLUGIN)
		dk_debug("################################ ${CURRENT_PLUGIN} CONTINUE ############################")
	endif()

endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_depend(zlib)
endfunction()
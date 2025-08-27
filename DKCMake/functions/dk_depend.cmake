#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


#########################################################################
# dk_depend(PLUGIN_Import_Name) target
#
#	Each PLUGIN_Import_Name invoked will fill a a varaible or it's name to the path where it
#   is installed..   
#   I.E.  dk_depend(zlib) =  dk_validate(ZLIB "dk_dependB(zlib)") 
#   Which says, "if ZLIB variable is not set,  call  3rdParty/_DKIMPORTS/zlib/DKINSTALL.cmake
#   to fill fill ZLIB with the path zlib is installed to.
#
function(dk_depend PLUGIN_Import_Name) #target
	dk_debugFunc(1 2)
	
	message("############ dk_depend(${PLUGIN_Import_Name}) ############")
	
	if(PLUGIN_Import_Name IN_LIST done_list)
		dk_debug("${PLUGIN_Import_Name} is already completed")
		return()
	endif()
	if(PLUGIN_Import_Name IN_LIST dk_disabled_list)
		if(DISABLED_LIBS MATCHES "${PLUGIN_Import_Name}")
			dk_append(DISABLED_LIBS "${PLUGIN_Import_Name}") # this list is for the build.log
		endif()
		dk_notice("${PLUGIN_Import_Name} IS DISABLED")
		return()
	endif()
	
	dk_toUpper("${PLUGIN_Import_Name}" PLUGIN)
	dk_convertToCIdentifier(${PLUGIN} PLUGIN)
	dk_set(PLUGIN "${PLUGIN}") 										# PLUGIN
	dk_getPathToPlugin(${PLUGIN_Import_Name} PLUGIN_Import_Path)
	dk_set(PLUGIN_Import_Path "${PLUGIN_Import_Path}") 				# PLUGIN_Import_Path
	dk_dirname("${PLUGIN_Import_Path}" PLUGIN_Import_Dirname)
	dk_set(PLUGIN_Import_Dirname "${PLUGIN_Import_Dirname}") 		# PLUGIN_Import_Dirname
	
	dk_debug("\n\n############################## ${PLUGIN} ENTER ##############################")
	dk_envList(PLUGIN PUSH "${PLUGIN}")
		


	dk_dependB(${PLUGIN_Import_Name})
	
	
	###### Pop Plugin from the PLUGIN_STACK ######
	list(APPEND done_list "${PLUGIN_Import_Name}")
	dk_set(done_list "${done_list}")
	dk_envList(PLUGIN POP)
	dk_debug("\n############################## ${PLUGIN} EXIT ##############################\n\n")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_depend(zlib)
endfunction()
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
# dk_depend(plugin) target
#
#	Each plugin invoked will fill a a varaible or it's name to the path where it
#   is installed..   
#   I.E.  dk_validate(ZLIB "dk_depend(zlib)") 
#   Which says, "if ZLIB variable is not set,  call  3rdParty/_DKIMPORTS/zlib/DKINSTALL.cmake
#   to fill fill ZLIB with the path zlib is installed to.
#
function(dk_depend plugin) #target
	dk_debugFunc(1 2)
	
	if(plugin IN_LIST dkdepend_list)
		return()
	endif()
		
	if(plugin IN_LIST dk_disabled_list)
		if(DISABLED_LIBS MATCHES "${plugin}")
			dk_append(DISABLED_LIBS "${plugin}") # this list is for the build.log
		endif()
		dk_notice("${plugin} IS DISABLED")
		return()
	endif()
	
	message("############ dk_depend(${plugin}) ############")
	
	dk_toUpper("${plugin}" PLUGIN)
	dk_convertToCIdentifier(${PLUGIN} CURRENT_PLUGIN)
	dk_set(CURRENT_PLUGIN "${CURRENT_PLUGIN}")
	
	dk_set(${CURRENT_PLUGIN}_Import_Name "${plugin}")							#<PLUGIN>_Import_Name
	dk_getPathToPlugin(${plugin} ${CURRENT_PLUGIN}_Import_Path)
	dk_importVariables(IMPORT_PATH "${${CURRENT_PLUGIN}_Import_Path}")
	#dk_set(${CURRENT_PLUGIN}_Import_Path "${${CURRENT_PLUGIN}_Import_Path}") 			#<PLUGIN>_Import_Path
	#dk_dirname("${${CURRENT_PLUGIN}_Import_Path}" ${CURRENT_PLUGIN}_Import_Dirname)
	#dk_set(${CURRENT_PLUGIN}_Import_Dirname "${${CURRENT_PLUGIN}_Import_Dirname}") 	#<PLUGIN>_Import_Dirname
	
	###### Push Plugin to the PLUGIN_STACK ######
	dk_debug("\n\n############################## ${CURRENT_PLUGIN} ENTER ##############################")
	dk_envList(PLUGIN PUSH "${CURRENT_PLUGIN}")
			
		list(APPEND dkdepend_list "${plugin}")
		dk_set(dkdepend_list "${dkdepend_list}")

		dk_load(${${CURRENT_PLUGIN}_Import_Path}/DKINSTALL.cmake)
			
		dk_enable(${plugin})
	 
	###### Pop Plugin from the PLUGIN_STACK ######
	dk_envList(PLUGIN POP)
	dk_debug("\n############################## ${CURRENT_PLUGIN} EXIT ##############################\n\n")

endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_depend(zlib)
endfunction()
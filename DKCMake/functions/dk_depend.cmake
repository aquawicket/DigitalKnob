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
#   I.E.  dk_depend(zlib) =  dk_validate(ZLIB "dk_dependB(zlib)") 
#   Which says, "if ZLIB variable is not set,  call  3rdParty/_DKIMPORTS/zlib/DKINSTALL.cmake
#   to fill fill ZLIB with the path zlib is installed to.
#
function(dk_depend plugin) #target
	dk_debugFunc(1 2)
	
	if(plugin IN_LIST done_list)
		dk_debug("${plugin} is already completed")
		return()
	endif()
	
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
	dk_convertToCIdentifier(${PLUGIN} PLUGIN)
	set(CURRENT_PLUGIN "${PLUGIN}")
	
	dk_set(${PLUGIN}_Import_Name "${plugin}")						#<PLUGIN>_Import_Name
	dk_getPathToPlugin(${plugin} ${PLUGIN}_Import_Path)
	dk_set(${PLUGIN}_Import_Path "${${PLUGIN}_Import_Path}") 		#<PLUGIN>_Import_Path
	dk_dirname("${${PLUGIN}_Import_Path}" ${PLUGIN}_Import_Dirname)
	dk_set(${PLUGIN}_Import_Dirname "${${PLUGIN}_Import_Dirname}") 	#<PLUGIN>_Import_Dirname
	
	if(NOT EXISTS "${${PLUGIN}_Install_Path}")
		
	###### Push Plugin to the PLUGIN_STACK ######
	dk_debug("\n\n############################## ${PLUGIN} ENTER ##############################")
	dk_envList(PLUGIN PUSH "${PLUGIN}")
			
		dk_set(CURRENT_IMPORT "${${PLUGIN}_Import_Path}")
		
	#	###### Load the dkconfig.txt file ######
	#	if(EXISTS "${${PLUGIN}_Import_Path}/dkconfig.txt")
	#		dk_getFileParams("${${PLUGIN}_Import_Path}/dkconfig.txt")
	#		dk_success("Loaded ${${PLUGIN}_Import_Path}/dkconfig.txt")
	#	else()
	#		dk_warning("${${PLUGIN}_Import_Path}/dkconfig.txt NOT FOUND.")
	#	endif()
	#	###### Load the DKINSTALL.cmake file ######

		dk_load(${${PLUGIN}_Import_Path}/DKINSTALL.cmake)
			
		dk_enable(${plugin})
	 
	###### Pop Plugin from the PLUGIN_STACK ######
	list(APPEND done_list "${plugin}")
	dk_set(done_list "${done_list}")
	dk_envList(PLUGIN POP)
	dk_debug("\n############################## ${PLUGIN} EXIT ##############################\n\n")

	else()
		dk_notice("dk_depend(): ${PLUGIN} is already loaded")
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_depend(zlib)
endfunction()
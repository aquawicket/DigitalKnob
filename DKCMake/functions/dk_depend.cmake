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
		return()  #plugin is already completed
	endif()
	
	message("############ dk_depend(${plugin}) ############")
	if(plugin IN_LIST dk_disabled_list)
		if(DISABLED_LIBS MATCHES "${plugin}")
			dk_append(DISABLED_LIBS "${plugin}") # this list is for the build.log
		endif()
		dk_notice("${plugin} IS DISABLED")
		return()
	endif()
	
	dk_toUpper("${plugin}" PLUGIN)
	dk_convertToCIdentifier(${PLUGIN} PLUGIN)
	set(CURRENT_PLUGIN "${PLUGIN}")
	
	dk_set(${PLUGIN}.Import_Name "${plugin}")						#<PLUGIN>.Import_Name
	dk_getPathToPlugin(${plugin} ${PLUGIN}.Import_Path)
	dk_set(${PLUGIN}.Import_Path "${${PLUGIN}.Import_Path}") 		#<PLUGIN>.Import_Path
	dk_dirname("${${PLUGIN}.Import_Path}" ${PLUGIN}.Import_Dirname)
	dk_set(${PLUGIN}.Import_Dirname "${${PLUGIN}.Import_Dirname}") 	#<PLUGIN>.Import_Dirname
	
	if(NOT EXISTS "${${PLUGIN}.Install_Path}")
		
		###### Push Plugin to the PLUGIN_STACK ######
		dk_debug("\n\n############################## ${PLUGIN} ENTER ##############################")
		dk_envList(PLUGIN PUSH "${PLUGIN}")
		
		#dk_notice("dk_depend(): loading ${PLUGIN} . . .")
		dk_dependB(${plugin})
	
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
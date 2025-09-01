#!/usr/bin/cmake -P
message("### dk_depend.cmake ###")

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
	#dk_delete("${${CURRENT_PLUGIN}_Build_Dir}/DKBUILD.log")
	dk_getPathToPlugin(${plugin} IMPORT_PATH)
	dk_basename("${IMPORT_PATH}" folder)
	dk_toUpper("${folder}" PLUGIN)
	dk_convertToCIdentifier(${PLUGIN} PLUGIN)
	#dk_set(CURRENT_PLUGIN "${PLUGIN}")
	
	###### Push Plugin to the PLUGIN_STACK ######
	dk_echo("\n")
	dk_debug(">>>>>########################### ${plugin} ENTER ##########################>>>>>")
	dk_envList(PLUGIN PUSH "${PLUGIN}")
			
		list(APPEND dkdepend_list "${plugin}")
		dk_set(dkdepend_list "${dkdepend_list}")

		#dk_importVariables(IMPORT_PATH "${IMPORT_PATH}")
		dk_load("${IMPORT_PATH}/DKINSTALL.cmake")
			
		dk_enable("${plugin}")
	 
	###### Pop Plugin from the PLUGIN_STACK ######
	
	dk_debug("<<<<<########################### ${CURRENT_PLUGIN} EXIT ###########################<<<<<\n")
	dk_envList(PLUGIN POP)
	dk_debug(">>>>>########################### ${CURRENT_PLUGIN} CONTINUE #######################>>>>>")

endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_depend(zlib)
endfunction()
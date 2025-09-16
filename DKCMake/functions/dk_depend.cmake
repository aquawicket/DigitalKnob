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
# dk_depend(Plugin) target
#
#	Each Plugin invoked will fill a a varaible or it's name to the path where it
#   is installed..   
#   I.E.  dk_validate(ZLIB "dk_depend(zlib)") 
#   Which says, "if ZLIB variable is not set,  call  3rdParty/_DKIMPORTS/zlib/DKINSTALL.cmake
#   to fill fill ZLIB with the path zlib is installed to.
#
function(dk_depend Plugin)
	dk_debugFunc(1 2)
	
	#set(Plugin "${ARGV0}")
	dk_allButFirstArgs(${ARGV})
	message("############ dk_depend(${Plugin} ${dk_allButFirstArgs}) ############")
	
	set(dkdepend_list $CACHE{dkdepend_list})
	if(Plugin IN_LIST dkdepend_list)
		dk_notice("${Plugin} already added to dependency list")
		return()
	endif()
		
	if(Plugin IN_LIST dkdisabled_list)
		if(DISABLED_LIBS MATCHES "${Plugin}")
			dk_append(DISABLED_LIBS "${Plugin}") # this list is for the build.log
		endif()
		dk_notice("${Plugin} IS DISABLED")
		return()
	endif()

	#dk_delete("${${CURRENT_PLUGIN}_Build_Dir}/DKBUILD.log")
	
	###### Push Plugin to the PLUGIN_STACK ######
	set(PLUGIN_Stack "$ENV{PLUGIN_Stack}")		### copy the env variable to local variable
	if(Plugin IN_LIST PLUGIN_Stack)
		dk_notice("${Plugin} already in PLUGIN_Stack")
		return()
	endif()
	dk_envList(PLUGIN PUSH "${Plugin}")
	
	dk_echo("\n")
	dk_echo("\n")
	dk_debug(">>>>>##############################################################################>>>>>")
	dk_debug(">>>>>########################### ${CURRENT_PLUGIN} ENTER ##########################>>>>>")
	dk_debug(">>>>>##############################################################################>>>>>")
		dk_title("${PLUGIN_Stack}")
	
		list(APPEND dkdepend_list "${CURRENT_PLUGIN}")
		dk_set(dkdepend_list "${dkdepend_list}") 									# Globalize the variable
		dk_debug("dkdepend_list = ${dkdepend_list}") 
		
		dk_getPathToPlugin(${CURRENT_PLUGIN} ${CURRENT_PLUGIN}_Import_Path)
		dk_set(${CURRENT_PLUGIN}_Import_Path "${${CURRENT_PLUGIN}_Import_Path}")	# Globalize the variable

		dk_enable("${CURRENT_PLUGIN}")
		
		#dk_importVariables(Import_Path "${Import_Path}")
		dk_load("${${CURRENT_PLUGIN}_Import_Path}/DKINSTALL.cmake")
		dk_fileIncludes("${${CURRENT_PLUGIN}_Import_Path}/DKINSTALL.cmake" "function(DKINSTALL")
		if(dk_fileIncludes)
			dk_debug("${CURRENT_PLUGIN}: DKINSTALL(${dk_allButFirstArgs})")
			DKINSTALL(${dk_allButFirstArgs})
		endif()
		
			
	###### Pop Plugin from the PLUGIN_STACK ######
	#dk_debug("<<<<<########################### ${CURRENT_PLUGIN} EXIT ###########################<<<<<\n")
	dk_envList(PLUGIN POP)
	dk_echo("\n")
	dk_debug(">>>>>########################### ${CURRENT_PLUGIN} CONTINUE #######################>>>>>")

endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_depend(zlib)
endfunction()
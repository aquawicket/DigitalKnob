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
# dk_getPathToPlugin(PLUGIN_Import_Name rtn_var)
#
#	@PLUGIN_Import_Name		- TODO
#	@rtn_var		- TODO
#
function(dk_getPathToPlugin PLUGIN_Import_Name rtn_var)
	dk_debugFunc()
	
	list(FIND dk_disabled_list "${ARGV}" index)
	if(${index} GREATER -1)
		dk_info("${ARGV} IS DISABLED")
		return()
	endif()

	#file(GLOB children RELATIVE $ENV{DIGITALKNOB_DIR} $ENV{DIGITALKNOB_DIR}/*)
 	#foreach(child ${children})
		#dk_printVar(child)
		#if(EXISTS $ENV{DIGITALKNOB_DIR}/${child}/3rdParty/_DKIMPORTS/${PLUGIN_Import_Name}/DKINSTALL.cmake)
		#	set(${rtn_var} "$ENV{DIGITALKNOB_DIR}/${child}/3rdParty/_DKIMPORTS/${PLUGIN_Import_Name}" PARENT_SCOPE)
		#	return()
    	#endif()
		#dk_debug($ENV{DKIMPORTS_DIR}/${PLUGIN_Import_Name}/DKINSTALL.cmake)
		dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
		if(EXISTS $ENV{DKIMPORTS_DIR}/${PLUGIN_Import_Name}/DKINSTALL.cmake)
			set(${rtn_var} "$ENV{DKIMPORTS_DIR}/${PLUGIN_Import_Name}" PARENT_SCOPE)
			return()
    	endif()
		#if(EXISTS $ENV{DIGITALKNOB_DIR}/${child}/plugins/${PLUGIN_Import_Name}/DKINSTALL.cmake)
		#	set(${rtn_var} "$ENV{DIGITALKNOB_DIR}/${child}/plugins/${PLUGIN_Import_Name}" PARENT_SCOPE)
		#	return()
    	#endif()
		dk_validate(DKCPP_PLUGINS_DIR "dk_DKBRANCH_DIR()")
		if(EXISTS ${DKCPP_PLUGINS_DIR}/${PLUGIN_Import_Name}/DKINSTALL.cmake)
			set(${rtn_var} "${DKCPP_PLUGINS_DIR}/${PLUGIN_Import_Name}" PARENT_SCOPE)
			return()
    	endif()
		dk_validate(DKCPP_APPS_DIR "dk_DKBRANCH_DIR()")
		if(EXISTS ${DKCPP_APPS_DIR}/${PLUGIN_Import_Name}/DKINSTALL.cmake)
			set(${rtn_var} "${DKCPP_APPS_DIR}/${PLUGIN_Import_Name}" PARENT_SCOPE)
			return()
    	endif()
  	#endforeach()
	
	set(${rtn_var} "")
	dk_fatal("Could not find ${PLUGIN_Import_Name} Plugin.")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()
#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development


###############################################################################
# dk_getPathToPlugin(plugin rtn_var)
#
#	@plugin		- TODO
#	@rtn_var		- TODO
#
function(dk_getPathToPlugin plugin rtn_var)
	dk_debugFunc()
	
	list(FIND dk_disabled_list "${ARGV}" index)
	if(${index} GREATER -1)
		dk_info("${ARGV} IS DISABLED")
		return()
	endif()

<<<<<<< HEAD
	#file(GLOB children RELATIVE ${DIGITALKNOB_DIR} ${DIGITALKNOB_DIR}/*)
 	#foreach(child ${children})
		#dk_printVar(child)
		#if(EXISTS ${DIGITALKNOB_DIR}/${child}/3rdParty/_DKIMPORTS/${plugin}/DKMAKE.cmake)
		#	set(${rtn_var} "${DIGITALKNOB_DIR}/${child}/3rdParty/_DKIMPORTS/${plugin}" PARENT_SCOPE)
		#	return()
    	#endif()
		#dk_debug(${DKIMPORTS_DIR}/${plugin}/DKMAKE.cmake)
		dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
		if(EXISTS ${DKIMPORTS_DIR}/${plugin}/DKMAKE.cmake)
			set(${rtn_var} "${DKIMPORTS_DIR}/${plugin}" PARENT_SCOPE)
			return()
    	endif()
		#if(EXISTS ${DIGITALKNOB_DIR}/${child}/DKPlugins/${plugin}/DKMAKE.cmake)
		#	set(${rtn_var} "${DIGITALKNOB_DIR}/${child}/DKPlugins/${plugin}" PARENT_SCOPE)
		#	return()
    	#endif()
		dk_validate(DKPLUGINS_DIR "dk_DKPLUGINS_DIR()")
		if(EXISTS ${DKPLUGINS_DIR}/${plugin}/DKMAKE.cmake)
			set(${rtn_var} "${DKPLUGINS_DIR}/${plugin}" PARENT_SCOPE)
=======
	#file(GLOB children RELATIVE $ENV{DIGITALKNOB_DIR} $ENV{DIGITALKNOB_DIR}/*)
 	#foreach(child ${children})
		#dk_printVar(child)
		#if(EXISTS $ENV{DIGITALKNOB_DIR}/${child}/3rdParty/_DKIMPORTS/${plugin}/DKINSTALL.cmake)
		#	set(${rtn_var} "$ENV{DIGITALKNOB_DIR}/${child}/3rdParty/_DKIMPORTS/${plugin}" PARENT_SCOPE)
		#	return()
    	#endif()
		#dk_debug($ENV{DKIMPORTS_DIR}/${plugin}/DKINSTALL.cmake)
		dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
		if(EXISTS $ENV{DKIMPORTS_DIR}/${plugin}/DKINSTALL.cmake)
			set(${rtn_var} "$ENV{DKIMPORTS_DIR}/${plugin}" PARENT_SCOPE)
			return()
    	endif()
		#if(EXISTS $ENV{DIGITALKNOB_DIR}/${child}/plugins/${plugin}/DKINSTALL.cmake)
		#	set(${rtn_var} "$ENV{DIGITALKNOB_DIR}/${child}/plugins/${plugin}" PARENT_SCOPE)
		#	return()
    	#endif()
		dk_validate(DKCPP_PLUGINS_DIR "dk_DKBRANCH_DIR()")
		if(EXISTS ${DKCPP_PLUGINS_DIR}/${plugin}/DKINSTALL.cmake)
			set(${rtn_var} "${DKCPP_PLUGINS_DIR}/${plugin}" PARENT_SCOPE)
>>>>>>> Development
			return()
    	endif()
  	#endforeach()
	
	set(${rtn_var} "")
	dk_fatal("Could not find ${plugin} Plugin.")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_todo()
endfunction()
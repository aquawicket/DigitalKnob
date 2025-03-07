#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()


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
		#if(EXISTS ${DIGITALKNOB_DIR}/${child}/plugins/${plugin}/DKMAKE.cmake)
		#	set(${rtn_var} "${DIGITALKNOB_DIR}/${child}/plugins/${plugin}" PARENT_SCOPE)
		#	return()
    	#endif()
		dk_validate(DKCPP_PLUGINS_DIR "dk_DKBRANCH_DIR()")
		if(EXISTS ${DKCPP_PLUGINS_DIR}/${plugin}/DKMAKE.cmake)
			set(${rtn_var} "${DKCPP_PLUGINS_DIR}/${plugin}" PARENT_SCOPE)
			return()
    	endif()
  	#endforeach()
	
	set(${rtn_var} "")
	dk_fatal("Could not find ${plugin} Plugin.")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()
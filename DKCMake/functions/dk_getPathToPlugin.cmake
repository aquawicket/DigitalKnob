include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()


###############################################################################
# dk_getPathToPlugin(plugin rtn_var)
#
#	@plugin		- TODO
#	@rtn_var		- TODO
#
function(dk_getPathToPlugin plugin rtn_var)
	dk_debugFunc(${ARGV})
	
	list(FIND dk_disabled_list "${ARGV}" index)
	if(${index} GREATER -1)
		dk_info("${ARGV} IS DISABLED")
		return()
	endif()

	dk_validate(DKIMPORTS_DIR "dk_validateBranch()")
	#file(GLOB children RELATIVE ${DIGITALKNOB_DIR} ${DIGITALKNOB_DIR}/*)
 	#foreach(child ${children})
		#dk_printVar(child)
		#if(EXISTS ${DIGITALKNOB_DIR}/${child}/3rdParty/_DKIMPORTS/${plugin}/DKMAKE.cmake)
		#	set(${rtn_var} "${DIGITALKNOB_DIR}/${child}/3rdParty/_DKIMPORTS/${plugin}" PARENT_SCOPE)
		#	return()
    	#endif()
		#dk_debug(${DKIMPORTS_DIR}/${plugin}/DKMAKE.cmake)
		if(EXISTS ${DKIMPORTS_DIR}/${plugin}/DKMAKE.cmake)
			set(${rtn_var} "${DKIMPORTS_DIR}/${plugin}" PARENT_SCOPE)
			return()
    	endif()
		#if(EXISTS ${DIGITALKNOB_DIR}/${child}/DKPlugins/${plugin}/DKMAKE.cmake)
		#	set(${rtn_var} "${DIGITALKNOB_DIR}/${child}/DKPlugins/${plugin}" PARENT_SCOPE)
		#	return()
    	#endif()
		if(EXISTS ${DKPLUGINS_DIR}/${plugin}/DKMAKE.cmake)
			set(${rtn_var} "${DKPLUGINS_DIR}/${plugin}" PARENT_SCOPE)
			return()
    	endif()
  	#endforeach()
	
	set(${rtn_var} "")
	dk_error("Could not find ${plugin} Plugin.")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()
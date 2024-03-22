include_guard()

###############################################################################
# dk_getPathToPlugin(plugin RESULT)
#
#	@plugin		- TODO
#	@RESULT		- TODO
#
function(dk_getPathToPlugin plugin RESULT)
	DKDEBUGFUNC(${ARGV})
	list(FIND dk_disabled_list "${ARGV}" index)
	if(${index} GREATER -1)
		dk_info("${ARGV} IS DISABLED")
		return()
	endif()
	
	#file(GLOB children RELATIVE ${DIGITALKNOB_DIR} ${DIGITALKNOB_DIR}/*)
 	#foreach(child ${children})
		#message(STATUS ${child})
		#if(EXISTS ${DIGITALKNOB_DIR}/${child}/3rdParty/_DKIMPORTS/${plugin}/DKMAKE.cmake)
		#	set(${RESULT} "${DIGITALKNOB_DIR}/${child}/3rdParty/_DKIMPORTS/${plugin}" PARENT_SCOPE)
		#	return()
    	#endif()
		#message(STATUS ${DKIMPORTS_DIR}/${plugin}/DKMAKE.cmake)
		if(EXISTS ${DKIMPORTS_DIR}/${plugin}/DKMAKE.cmake)
			set(${RESULT} "${DKIMPORTS_DIR}/${plugin}" PARENT_SCOPE)
			return()
    	endif()
		#if(EXISTS ${DIGITALKNOB_DIR}/${child}/DKPlugins/${plugin}/DKMAKE.cmake)
		#	set(${RESULT} "${DIGITALKNOB_DIR}/${child}/DKPlugins/${plugin}" PARENT_SCOPE)
		#	return()
    	#endif()
		if(EXISTS ${DKPLUGINS_DIR}/${plugin}/DKMAKE.cmake)
			set(${RESULT} "${DKPLUGINS_DIR}/${plugin}" PARENT_SCOPE)
			return()
    	endif()
  	#endforeach()
	
	set(${RESULT} "")
	dk_error("Could not find ${plugin} Plugin.")
endfunction()
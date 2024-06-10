include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

# FIXME: This is not fully functional. It take code from dk_getOptionValue() 
# but has not yet ben set up to recieve multiple variables, or been tested
###############################################################################
# dk_getOptionValues(name ${ARGV}) 
#
#	TODO: change to dk_getOptionValue(name output ${ARGV}) so we ca choose the variable to recieve the option in
#
#	EXAMPLE: dk_getOptionValues(MY_ARG ${ARGV})
#
function(dk_getOptionValues name)
	dk_debugFunc(${ARGV})
	
	cmake_parse_arguments(ARG "" "${name}" "" ${ARGN})
	cmake_parse_arguments(ARG REMOVE "" "" ${ARGN})
	#dk_printPrefixVars("ARG_")
	if(ARG_${name})
		set(${name} ${ARG_${name}} PARENT_SCOPE)
		if(ARG_REMOVE)
			set(ARG_LIST ${ARGN})
			list(REMOVE_ITEM ARG_LIST ${name})
			list(REMOVE_ITEM ARG_LIST ${ARG_${name}})
			list(REMOVE_ITEM ARG_LIST REMOVE)
			set(ARGV ${ARG_LIST} PARENT_SCOPE)
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(${name} ${ARG_${name}}) REMOVED")
			dk_notice("${name} REMOVED")
		endif()
	else()
		unset(${name})
		#dk_debug("${CMAKE_CURRENT_FUNCTION}(): ${name}=OFF")
	endif()
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)
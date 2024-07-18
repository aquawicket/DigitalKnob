include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_getOptionValue(name ${ARGV}) 
#
#	TODO: change to dk_getOptionValue(name output ${ARGV}) so we can choose the variable to recieve the option in
#
#	EXAMPLE: dk_getOptionValue(MY_ARG ${ARGV})
#
function(dk_getOptionValue name)
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
		dk_unset(${name})
		#dk_debug("${CMAKE_CURRENT_FUNCTION}(): ${name}=OFF")
	endif()
endfunction()




function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()
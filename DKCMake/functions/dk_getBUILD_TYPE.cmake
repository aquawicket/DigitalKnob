include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

######################################################################
# dk_getBUILD_TYPE()
#  
#
function(dk_getBUILD_TYPE)
	dk_debugFunc(${ARGV})
	
	while(NOT DEFINED DEBUG AND NOT DEFINED RELEASE)
		dk_echo()
		dk_echo(" 1) Debug")
		dk_echo(" 2) Release")
		dk_echo(" 3) All")
		dk_echo(" 4) Exit")
		dk_echo()
		
		dk_keyboardInput(input)
		if("${input}" EQUAL "1")
			dk_set(DEBUG ON)
		elseif("${input}" EQUAL "2")
			dk_set(RELEASE ON)
		elseif("${input}" EQUAL "3")
			dk_set(DEBUG ON)
			dk_set(RELEASE ON)
		elseif("${input}" EQUAL "4")
			dk_exit(0)
		else()
			dk_warning("invalid selection")
		endif()
	endwhile()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_getBUILD_TYPE()
endfunction()
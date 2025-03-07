#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

######################################################################
# dk_target_type()
#  
#
function(dk_target_type)
	dk_debugFunc()
	
	if(CMAKE_SCRIPT_MODE_FILE)
		dk_echo()
		dk_echo(" 1) Debug")
		dk_echo(" 2) Release")
		dk_echo(" 3) Debug;Release")
		dk_echo(" 4) Exit")
		dk_echo()
			
		dk_keyboardInput(input)
		if("${input}" EQUAL "1")
			dk_set(target_type "Debug")
			#dk_set(debug ON)
			#dk_set(Debug ON)
			dk_set(DEBUG ON)
		elseif("${input}" EQUAL "2")
			dk_set(target_type "Release")
			#dk_set(release ON)
			#dk_set(Release ON)			
			dk_set(RELEASE ON)
		elseif("${input}" EQUAL "3")
			dk_set(target_type "Debug;Release")
			#dk_set(debug ON)
			#dk_set(Debug ON)
			dk_set(DEBUG ON)
			#dk_set(release ON)
			#dk_set(Release ON)			
			dk_set(RELEASE ON)
		elseif("${input}" EQUAL "4")
			dk_exit(0)
		else()
			dk_warning("invalid selection")
		endif()
		
		dk_assertVar(target_type)
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_target_type()
endfunction()
#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# dk_removeSubstring(removethis fromthis rtn_var)
#
#	TODO
#
#	@removethis		- TODO
#	@fromthis		- TODO
#	@rtn_var			- TODO
#
function(dk_removeSubstring removethis fromthis rtn_var)
	dk_debugFunc(3)

	dk_replaceAll("${fromthis}" "${removethis}" "" removeSubstring)
	#dk_printVar(removeSubstring)
	set("${rtn_var}" "${removeSubstring}" PARENT_SCOPE)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(myString "You have never had a good day today or anyday")
	dk_removeSubstring("have never " "${myString}" myString)
	dk_removeSubstring(" or anyday" "${myString}" myString)
	dk_info("${myString}")
endfunction()
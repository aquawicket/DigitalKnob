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
# dk_replaceAll("input" "searchValue" "newValue" rtn_var)
#
#
function(dk_replaceAll input searchValue newValue rtn_var)
	dk_debugFunc()
		
	string(REPLACE "${searchValue}" "${newValue}" replaceAll "${input}")
	
	if("${rtn_var}" MATCHES "ENV{")
		set(${rtn_var} ${replaceAll})
	else()
		set(${rtn_var} ${replaceAll} PARENT_SCOPE)
	endif()
endfunction()



function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc()
	
	set(string_var "AZC AZC Zannana Zread")
	#set(string_var "C:/Users/Administrator/DigitalKnob/download/msys2-x86_64-20231026.exe")
	dk_info("string before:  ${string_var}")
	
	dk_replaceAll("${string_var}" "Z" "B" string_var)
	
	dk_info("string after:  ${string_var}")
endfunction()

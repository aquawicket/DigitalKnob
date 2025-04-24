#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development


##################################################################################
# dk_replaceAll("input" "searchValue" "newValue" rtn_var)
#
#
function(dk_replaceAll input searchValue newValue rtn_var)
	dk_debugFunc()
<<<<<<< HEAD
	if(NOT ${ARGC} EQUAL 4)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments:${ARGC}")
	endif()
=======
>>>>>>> Development
		
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

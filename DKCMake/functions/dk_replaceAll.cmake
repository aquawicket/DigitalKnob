include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()


##################################################################################
# dk_replaceAll("input" "searchValue" "newValue" rtn_var)
#
#
function(dk_replaceAll input searchValue newValue rtn_var)
	dk_debugFunc(${ARGV})
	if(NOT ${ARGC} EQUAL 4)
		dk_error("${CMAKE_CURRENT_FUNCTION}(${ARGC}): incorrect number of arguments")
	endif()
		
	string(REPLACE "${searchValue}" "${newValue}" replaceAll "${input}")
	#dk_printVar(replaceAll)
	set(${rtn_var} ${replaceAll} PARENT_SCOPE)
endfunction()



function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc(${ARGV})
	
	set(string_var "AZC AZC Zannana Zread")
	dk_info("string before:  ${string_var}")
	
	dk_replaceAll("${string_var}" "Z" "B" string_var)
	
	dk_info("string after:  ${string_var}")
endfunction()
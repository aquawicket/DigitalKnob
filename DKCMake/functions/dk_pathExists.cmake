#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()


##################################################################################
# dk_pathExists(path rtn_var)
#
#
function(dk_pathExists path rtn_var)
	dk_debugFunc()
	
	
	if(EXISTS "${path}")
		set(pathExists 1)
	else()
		set(pathExists 0)
	endif()
	
	#dk_printVar(pathExists)
	set(${rtn_var} ${pathExists} PARENT_SCOPE)
endfunction()




function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc()
	
	
	dk_pathExists("dk_debug.cmake" dk_pathExists_dk_debug_sh)
	if(dk_pathExists_dk_debug_sh)
		dk_info("The path exists")
	else()
		dk_info("The path does NOT exist")
	endif()
	
	dk_pathExists("nofile.ext" dk_pathExists_nofile_ext)
	if(dk_pathExists_nofile_ext)
		dk_info("The path exists")
	else()
		dk_info("The path does NOT exist")
	endif()
	
	dk_pathExists("${PWD}" dk_pathExists_PWD)
	if(dk_pathExists_PWD)
		dk_info("The path exists")
	else()
		dk_info("The path does NOT exist")
	endif()
endfunction()
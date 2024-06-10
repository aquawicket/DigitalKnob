include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()


##################################################################################
# dk_pathExists(<path>)
#
#
function(dk_pathExists path output)
	dk_debugFunc(${ARGV})
	
	if(EXISTS "${path}")
		set(${output} 1 PARENT_SCOPE)
	endif()
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_pathExists("dk_debug.cmake" dk_pathExists_dk_debug_sh)
	if(dk_pathExists_dk_debug_sh)
		dk_echo("The path exists")
	else()
		dk_echo("The path does NOT exist")
	endif()
	
	dk_pathExists("nofile.ext" dk_pathExists_nofile_ext)
	if(dk_pathExists_nofile_ext)
		dk_echo("The path exists")
	else()
		dk_echo("The path does NOT exist")
	endif()
	
	dk_pathExists("${PWD}" dk_pathExists_PWD)
	if(dk_pathExists_PWD)
		dk_echo("The path exists")
	else()
		dk_echo("The path does NOT exist")
	endif()
endfunction()






function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)
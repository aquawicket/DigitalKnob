#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

################################################################################
# dk_exportVars(var_name, var_value)
#
#
function(dk_exportVars var_name var_value)
	dk_debugFunc()
	
	dk_validate(DKCACHE_DIR "dk_DKHOME_DIR()")
	if(WIN_HOST)
		dk_fileAppend("${DKCACHE_DIR}/DKEXPORT_VARS" "SET ${var_name}=${var_value}\n")
	else()
		dk_fileAppend("${DKCACHE_DIR}/DKEXPORT_VARS" "export ${var_name}=${var_value}\n")
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_exportVars(TEST_VAR "value of Test_var variable")
endfunction()
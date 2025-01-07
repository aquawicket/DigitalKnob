#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

################################################################################
# dk_exportVars(var_name, var_value)
#
#
function(dk_exportVars var_name var_value)
	dk_debugFunc()
	
    dk_echo("EXPORTING VARIABLES ......")
	dk_validate(DKCACHE_DIR "dk_DKCACHE_DIR()")
	
	if(EXISTS "${DKCACHE_DIR}/DKEXPORT_VARS")
		dk_fileIncludes("${DKCACHE_DIR}/DKEXPORT_VARS" "SET ${var_name}=${var_value}\n")
		if(dk_fileIncludes)
			dk_notice("Path already exists in file")
			dk_return()
		endif()
		dk_fileIncludes("${DKCACHE_DIR}/DKEXPORT_VARS" "export ${var_name}=${var_value}\n")
		if(dk_fileIncludes)
			dk_notice("Path already exists in file")
			dk_return()
		endif()
	endif()
	
	
	if(WIN_HOST)
		dk_fileAppend("${DKCACHE_DIR}/DKEXPORT_VARS" "SET ${var_name}=${var_value}\n")
	else()
		dk_fileAppend("${DKCACHE_DIR}/DKEXPORT_VARS" "export ${var_name}=${var_value}\n")
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_exportVars(TEST_VAR "value of Test_var variable")
endfunction()
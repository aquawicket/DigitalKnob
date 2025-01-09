#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

################################################################################
# dk_exportVars(var_name, var_value)
#
#
function(dk_exportVars var_name var_value)
	dk_debugFunc()
	
	dk_validate(host_triple "dk_host_triple()")
	if(WIN_HOST)
		set(setVar "set")
	else()
		set(setVar "export")
	endif()
	
	dk_validate(DKCACHE_DIR "dk_DKCACHE_DIR()")
	if(EXISTS "${DKCACHE_DIR}/DKEXPORT_VARS")
		dk_fileIncludes("${DKCACHE_DIR}/DKEXPORT_VARS" "${setVar} ${var_name}=${var_value}\n")
		if(dk_fileIncludes)
			dk_notice("${setVar} ${var_name}=${var_value}: already exists in file")
			dk_return()
		endif()
	endif()
	
	dk_fileAppend("${DKCACHE_DIR}/DKEXPORT_VARS" "${setVar} ${var_name}=${var_value}\n")
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_exportVars(TEST_VAR "value of Test_var variable")
endfunction()
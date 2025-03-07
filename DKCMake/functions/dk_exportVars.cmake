#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

################################################################################
# dk_exportVars(var_name, var_value)
#
#
function(dk_exportVars var_name var_value)
	dk_debugFunc()
	
	dk_validate(host_triple "dk_host_triple()")
	if(WIN_HOST)
		set(export "set")
	else()
		set(export "export")
	endif()
	
	dk_validate(DKCACHE_DIR "dk_DKCACHE_DIR()")
	if(EXISTS "${DKCACHE_DIR}/DKEXPORT_VARS")
		dk_fileIncludes("${DKCACHE_DIR}/DKEXPORT_VARS" "${export} ${var_name}=${var_value}")
		if(dk_fileIncludes)
			dk_notice("DKEXPORT_VARS already contains '${export} ${var_name}=${var_value}'")
			dk_return()
		endif()
	endif()
	
	dk_fileAppend("${DKCACHE_DIR}/DKEXPORT_VARS" "${export} ${var_name}=${var_value}\n")
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_exportVars(TEST_VAR "value of Test_var variable")
	dk_exportVars(TEST_VAR "value of Test_var variable")
	dk_exportVars(TEST_VAR "value of Test_var variable")
	dk_exportVars(TEST_VAR "value of Test_var variable")
	dk_exportVars(ABC "123")
	dk_exportVars(TEST_VAR "value of Test_var variable")
	dk_exportVars(ABC "123")
endfunction()
#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

################################################################################
# dk_exportVars(var_name, var_value)
#
#
function(dk_exportVars var_name var_value)
	dk_debugFunc()
	
<<<<<<< HEAD
    dk_echo("EXPORTING VARIABLES ......")
	dk_validate(DKCACHE_DIR "dk_DKHOME_DIR()")
	if(WIN_HOST)
		dk_fileAppend("${DKCACHE_DIR}/DKEXPORT_VARS" "SET ${var_name}=${var_value}\n")
	else()
		dk_fileAppend("${DKCACHE_DIR}/DKEXPORT_VARS" "export ${var_name}=${var_value}\n")
	endif()
=======
	dk_validate(host_triple "dk_host_triple()")
	if(WIN_HOST)
		set(export "set")
	else()
		set(export "export")
	endif()
	
	dk_validate(ENV{DKCACHE_DIR{ "dk_DKCACHE_DIR()")
	if(EXISTS "$ENV{DKCACHE_DIR}/DKEXPORT_VARS")
		dk_fileIncludes("$ENV{DKCACHE_DIR}/DKEXPORT_VARS" "${export} ${var_name}=${var_value}")
		if(dk_fileIncludes)
			dk_notice("DKEXPORT_VARS already contains '${export} ${var_name}=${var_value}'")
			dk_return()
		endif()
	endif()
	
	dk_fileAppend("$ENV{DKCACHE_DIR}/DKEXPORT_VARS" "${export} ${var_name}=${var_value}\n")
>>>>>>> Development
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_exportVars(TEST_VAR "value of Test_var variable")
=======
	dk_debugFunc(0)
	
	dk_exportVars(TEST_VAR "value of Test_var variable")
	dk_exportVars(TEST_VAR "value of Test_var variable")
	dk_exportVars(TEST_VAR "value of Test_var variable")
	dk_exportVars(TEST_VAR "value of Test_var variable")
	dk_exportVars(ABC "123")
	dk_exportVars(TEST_VAR "value of Test_var variable")
	dk_exportVars(ABC "123")
>>>>>>> Development
endfunction()
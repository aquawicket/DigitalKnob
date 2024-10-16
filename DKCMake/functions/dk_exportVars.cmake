include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

################################################################################
# dk_exportVars(var_name, var_value)
#
#
function(dk_exportVars var_name var_value)
	dk_debugFunc("\${ARGV}")
	
	if(WIN_HOST)
		dk_fileAppend("${DKTEMP_DIR}/DKEXPORT_VARS" "SET ${var_name}=${var_value}\n")
	else()
		dk_fileAppend("${DKTEMP_DIR}/DKEXPORT_VARS" "export ${var_name}=${var_value}\n")
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_exportVars(TEST_VAR "value of Test_var variable")
endfunction()
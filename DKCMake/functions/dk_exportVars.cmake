include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

################################################################################
# dk_exportVars(var_name, var_value)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_at
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/at
#
function(dk_exportVars var_name var_value)
	dk_debugFunc(${ARGV})
	
	if(WIN_HOST)
		dk_fileAppend("$ENV{TEMP}/DKEXPORT_VARS.cmd" "SET ${var_name}=${var_value}\n")
	else()
		dk_fileAppend("$ENV{TEMP}/DKEXPORT_VARS.sh" "SET ${var_name}=${var_value}\n")
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	
endfunction()
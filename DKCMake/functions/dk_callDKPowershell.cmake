#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_callDKPowershell(func, args)
#
#
function(dk_callDKPowershell func)
	dk_debugFunc("\${ARGV}")
	math(EXPR ARGC_LAST "${ARGC}-1")
	set(ARGV_LAST ${ARGV${ARGC_LAST}})
	dk_debug("ARGV_LAST = ${ARGV_LAST}")
	
	find_program(POWERSHELL_EXE powershell.exe)
	dk_validate(DKPOWERSHELL_FUNCTIONS_DIR "dk_DKBRANCH_DIR()")
	set(ALL_BUT_FIRST_ARGS ${ARGN})
	execute_process(COMMAND "${POWERSHELL_EXE}" -Command . '${DKPOWERSHELL_FUNCTIONS_DIR}/${func}.ps1'; ${func} ${ARGN} WORKING_DIRECTORY "${DKPOWERSHELL_FUNCTIONS_DIR}" OUTPUT_VARIABLE output_variable)
	dk_debug("output_variable = ${output_variable}")
	#if("${ARGV_LAST}" EQUAL "rtn_var")
		dk_debug("returning ARGV_LAST = ${ARGV_LAST}")
		set(${rtn_var} "${output_variable}" PARENT_SCOPE)
	#endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_callDKPowershell(dk_messageBox "Testing dk_messageBox" rtn_var)
	dk_debug("rtn_var = ${rtn_var}")
endfunction()

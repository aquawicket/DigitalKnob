#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_callDKPowershell(func, args)
#
#
function(dk_callDKPowershell func) #args
	dk_debugFunc("\${ARGV}")
	dk_debug("dk_callDKPowershell(${ARGV})")
	
	math(EXPR ARGC_LAST "${ARGC}-1")
	set(ARGV_LAST ${ARGV${ARGC_LAST}})
	
	find_program(POWERSHELL_EXE powershell.exe)
	dk_validate(DKPOWERSHELL_FUNCTIONS_DIR "dk_DKBRANCH_DIR()")
	if(DEFINED ENV{WSLENV})
		execute_process(COMMAND wslpath -m ${DKPOWERSHELL_FUNCTIONS_DIR} OUTPUT_VARIABLE DKPOWERSHELL_FUNCTIONS_DIR COMMAND_ECHO STDOUT OUTPUT_STRIP_TRAILING_WHITESPACE)
	endif()
	
	set(args ${ARGN})
	
	execute_process(COMMAND "${POWERSHELL_EXE}" -Command "\${DKSCRIPT_EXT}='${DKSCRIPT_EXT}'; . ${DKPOWERSHELL_FUNCTIONS_DIR}/${func}.ps1;" ${func} ${args} OUTPUT_VARIABLE output COMMAND_ECHO STDOUT OUTPUT_STRIP_TRAILING_WHITESPACE)
	
	dk_printVar(output)
	#if("${ARGV_LAST}" EQUAL "rtn_var")
		#dk_debug("returning ARGV_LAST = ${ARGV_LAST}")
		set(${rtn_var} "${output}" PARENT_SCOPE)
	#endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_callDKPowershell(dk_messageBox "\"Testing dk_messageBox\"")
	
endfunction()

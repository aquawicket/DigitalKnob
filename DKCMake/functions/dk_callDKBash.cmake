include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_callDKBash(func) args
#
#
function(dk_callDKBash func rtn_var)
	dk_debugFunc("\${ARGV}")
	
	dk_validate(BASH_EXE "dk_depend(git)")
	dk_validate(DKBASH_FUNCTIONS_DIR "dk_validateBranch()")
	execute_process(COMMAND ${BASH_EXE} -c "dk_messageBox.cmd" rtn_var ${ARGN} & echo %rtn_var% WORKING_DIRECTORY "${DKBATCH_FUNCTIONS_DIR}" OUTPUT_VARIABLE output_variable)
	dk_debug("output_variable = ${output_variable}")
	set(${rtn_var} "${output_variable}" PARENT_SCOPE)
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_callDKBash(dk_messageBox rtn_var "MessageBox Title" "Testing dk_messageBox")
	dk_debug("rtn_var = ${rtn_var}")
endfunction()

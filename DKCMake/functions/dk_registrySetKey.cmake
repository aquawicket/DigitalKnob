#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


#########################################################################
# dk_registrySetKey(key value data)
#
#	TODO
#
#	@key	- TODO
#	@value	- TODO
#	@data	- TODO
#
function(dk_registrySetKey key value data)
	dk_debugFunc()

	dk_validate(Host_Os "dk_Host_Os()")
	if(Windows_Host)
		dk_validate(reg_exe "dk_reg_exe()")
		dk_replaceAll(${key}  "/"  "\\"  key)
		dk_replaceAll(${value}  "/"  "\\"  value)
		dk_replaceAll(${data}  "/"  "\\"  data)
		#execute_process(COMMAND reg add "${key}" /v "${value}" /t REG_SZ /d "${data}" /f /reg:64 OUTPUT_VARIABLE _output ERROR_VARIABLE _output RESULT_VARIABLE _failed)
		dk_exec(${reg_exe} add "${key}" /v "${value}" /t REG_SZ /d "${data}" /f /reg:64 OUTPUT_VARIABLE _output)
		dk_verbose(dk_exec_output)
	else()
		dk_error("dk_registrySetKey() is only available on Windows_Host")
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	message("DKTEST")
	
	dk_set(dk_exec_PRINT_CALL		1) 			# dk_exec_call
	dk_set(dk_exec_PRINT_COMMAND	1) 			# dk_exec_command
	dk_set(dk_exec_PRINT_EXITCODES	1)			# dk_exec_exitcodes
	dk_set(dk_exec_PRINT_EXITCODE 	1)			# dk_exec_exitcode
	dk_set(dk_exec_PRINT_STDERR 	1)			# dk_exec_stderr[]
	dk_set(dk_exec_PRINT_STDOUT		1)			# dk_exec_stdout[]
	dk_set(dk_exec_PRINT_OUTPUT 	1)			# dk_exec

	dk_registrySetKey("HKCU/aquawicket/test" "test value" "user data test")
endfunction()
#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# dk_registryKeyExists() <reg_path>
#
function(dk_registryKeyExists)
    dk_debugFunc()
	
	dk_validate(Host_Os "dk_Host_Os()")
	if(Windows_Host)
		dk_validate(reg_exe "dk_depend(reg_exe)")
		dk_exec(${reg_exe} query ${ARGV0})
		dk_debug("dk_exec = ${dk_exec}")
	else()
		dk_error("dk_registryKeyExists() is only available on Windows_Host")
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
    
	dk_set(dk_exec_PRINT_CALL		1) 			# dk_exec_call
	dk_set(dk_exec_PRINT_COMMAND	1) 			# dk_exec_command
	dk_set(dk_exec_PRINT_EXITCODES	1)			# dk_exec_exitcodes
	dk_set(dk_exec_PRINT_EXITCODE 	1)			# dk_exec_exitcode
	dk_set(dk_exec_PRINT_STDERR 	1)			# dk_exec_stderr[]
	dk_set(dk_exec_PRINT_STDOUT		1)			# dk_exec_stdout[]
	dk_set(dk_exec_PRINT_OUTPUT 	1)			# dk_exec
	
    #dk_registryKeyExists("HKEY_CURRENT_USER/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.txt")
    dk_registryKeyExists(HKEY_CURRENT_USER)
	dk_registryKeyExists(HKEY_LOCAL_MACH)
endfunction()
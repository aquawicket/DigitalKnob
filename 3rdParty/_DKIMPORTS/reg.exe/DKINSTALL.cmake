#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "${DK_cmake}")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	message("DK_cmake = ${DK_cmake}")
	include("${DK_cmake}")
endif()
#########################################################################


####################################################################
# reg_exe
#
function(DKINSTALL)
dk_debugFunc(0 1)
	
	### Test if already valid
	if(EXISTS "${reg_exe}")
		execute_process(COMMAND "${reg_exe}" /? RESULT_VARIABLE exit_code OUTPUT_QUIET)
		if("${exit_code}" STREQUAL "0")
			return()
		endif()
	endif()

#	if(EXISTS "${reg_exe}")
#		message("reg_exe:'${reg_exe}' already exists")
#		dk_return()
#	endif()

	###### GET reg_exe ######
	if(NOT EXISTS "${reg_exe}")
		dk_findProgram(reg_exe reg.exe)
	endif()
	#if(NOT EXISTS "${reg_exe}")
	#	dk_debug("DKSHELL = ${DKSHELL}")
	#	execute_process(COMMAND $ENV{DKSHELL} -c "command -v reg" OUTPUT_VARIABLE reg_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	#endif()

	####### CHECK reg_exe ######
#	if(NOT EXISTS "${reg_exe}")
#		dk_fatal("reg_exe:'${reg_exe}' NOT FOUND")
#	endif()
	
	### Test command
	execute_process(COMMAND "${reg_exe}" /? RESULT_VARIABLE exit_code OUTPUT_QUIET)
	if(${exit_code})
		dk_error("reg_exe:'${reg_exe}' FAILED")
		return()
	endif()
	
	dk_set(reg_exe "${reg_exe}")
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_envList(PLUGIN POP)
	dk_unset(reg_exe)
	
	dk_validate(reg_exe "dk_depend(reg_exe)")
	dk_debug("reg_exe = ${reg_exe}")
	
	dk_validate(reg_exe "dk_depend(reg_exe)")
	dk_debug("reg_exe = ${reg_exe}")
endfunction()	
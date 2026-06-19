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
# dk_keyboard(rtn_var)
#
#
function(dk_keyboard)
	dk_debugFunc(0)

	dk_validate(cmd.exe "dk_depend(cmd.exe)")
	if(cmd.exe)
		dk_validate(ENV{DKBATCH_FUNCTIONS_DIR} "dk_DKBRANCH_DIR()")
		dk_chdir($ENV{DKBATCH_FUNCTIONS_DIR})
		dk_exec(${cmd.exe} /c $ENV{DKBATCH_FUNCTIONS_DIR}/dk_keyboard.cmd OUTPUT_VARIABLE rtn_var ECHO_OUTPUT_VARIABLE)
		#execute_process(COMMAND ${cmd.exe} /c $ENV{DKBATCH_FUNCTIONS_DIR}/dk_keyboard.cmd OUTPUT_VARIABLE rtn_var ECHO_OUTPUT_VARIABLE)
		dk_info("rtn_var = ${rtn_var}")
		return()
	endif()
	
	dk_validate(bash_exe "dk_depend(bash_exe)")
	if(bash_exe)
		dk_validate(DKBASH_FUNCTIONS_DIR "dk_DKBRANCH_DIR()")
		dk_exec(${DKBASH_FUNCTIONS_DIR}/dk_pause.sh & dk_pause)
		#execute_process(COMMAND ${DKBASH_FUNCTIONS_DIR}/dk_pause.sh & dk_pause)
		return()
	endif()
		
	dk_fatal("dk_getKey() failed:   both cmd.exe and bash_exe are invalid!")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_keyboard()
endfunction()
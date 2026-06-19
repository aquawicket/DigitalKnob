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
# dk_getKey(rtn_var)
#
#
function(dk_getKey rtn_var)
	dk_debugFunc(1)

	dk_validate(cmd.exe "dk_depend(cmd.exe)")
	if(cmd.exe)
		dk_fixme("${CMAKE_CURRENT_FUNCTION}")
		execute_process(COMMAND ${cmd.exe} /c pause)
		return()
	endif()
	
	dk_validate(bash_exe "dk_depend(bash_exe)")
	if(bash_exe)
		dk_fixme("${CMAKE_CURRENT_FUNCTION}")
		execute_process(COMMAND ${DKBASH_FUNCTIONS_DIR}/dk_pause.sh & dk_pause)
		return()
	endif()
		
	dk_fatal("dk_getKey() failed:   both cmd.exe and bash_exe are invalid!")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_getKey(result)
	dk_info("result = ${result}")
endfunction()
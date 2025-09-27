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

####################################################################
# dk_reg_exe()
#
#
function(dk_reg_exe)
    dk_debugFunc()

	###### SET ######
	if(ARGV)
		dk_set(reg_exe "${ARGV0}")
		
	###### GET ######
	elseif(DEFINED ENV{reg_exe})	
		dk_set(reg_exe "$ENV{reg_exe}")
	
	else()
		if(EXISTS "${reg_exe}")
			dk_debug("reg_exe:${reg_exe} already set")
			return()
		endif()
		
		dk_validate(cmd_exe "dk_depend(cmd_exe)")
		dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
		
		###### CYGPATH_EXE ######
		if(NOT EXISTS "${reg_exe}")
			set(reg_exe $ENV{reg_exe})
		endif()
		if(NOT EXISTS "${reg_exe}")
			dk_findProgram(reg_exe reg.exe)
		endif()
	endif()
	
	###### FINALIZE ######
	dk_set(reg_exe "${reg_exe}")		# Globalize the variable
	dk_assertPath(reg_exe)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
 
	dk_echo()
	dk_echo("Test Getting reg_exe . . .")
    dk_reg_exe()
	if(EXISTS "${reg_exe}")
		dk_success("reg_exe = ${reg_exe}")
	else()
		dk_error("reg_exe = ${reg_exe}")
	endif()
	
	
	dk_echo()
	dk_echo("Test Setting reg_exe . . .")
    dk_reg_exe("C:/reg.exe")
	if(EXISTS "${reg_exe}")
		dk_success("reg_exe = ${reg_exe}")
	else()
		dk_error("reg_exe = ${reg_exe}")
	endif()
endfunction()

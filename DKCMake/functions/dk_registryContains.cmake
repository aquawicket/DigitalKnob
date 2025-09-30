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


#################################################################################
# dk_registryContains(reg_path, find)
#
#
function(dk_registryContains)
	dk_debugFunc(2)

	set(_reg_path_ "${ARGV0}")
	string(REPLACE "/" "\\" _reg_path_ ${_reg_path_})
	set(_find_ "${ARGV1}")

	dk_validate(reg_exe "dk_depend(reg_exe)")
	
	dk_set(dk_exec_ECHO_OUTPUT	0)
	dk_exec(${reg_exe} query "${_reg_path_}")
	dk_set(dk_exec_ECHO_OUTPUT	1)
	#dk_debug("${dk_exec_stdout}")
	
	dk_includes("${dk_exec_stdout}" "${_find_}")
	if(dk_includes)
		set(dk_registryContains TRUE)
	else()
		set(dk_registryContains FALSE)
	endif()
	
	#dk_debug("dk_registryContains = ${dk_registryContains}")
    set(dk_registryContains ${dk_registryContains} PARENT_SCOPE)
endfunction()




function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc(0)
  
	set(key "HKLM/SYSTEM/ControlSet001/Services/SharedAccess/Parameters/FirewallPolicy/FirewallRules")
	set(value "C:")
  
	dk_registryContains("${key}" "${value}")
	if(dk_registryContains)
		dk_echo("FirewallRules contains ${value}")
	else()
		dk_echo("FirewallRules does NOT contain ${value}")
	endif()
endfunction()

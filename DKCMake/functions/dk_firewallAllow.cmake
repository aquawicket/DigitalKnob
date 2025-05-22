#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_firewallAllow(name executable)
#
#	@name		 	- The name of the firewall rule
#   @executable		- The path to the executable to allow
#
function(dk_firewallAllow)
	message("dk_firewallAllow.cmake(${ARGV})")
	dk_debugFunc(2)
	
	#dk_assertPath("${ARGV1}")
	dk_callDKBatch(dk_firewallAllow "${ARGV0}" "${ARGV1}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_firewallAllow("CMake-Gui" "C:/Users/Administrator/digitalknob/DKTools/cmake-3.29.5-windows-x86_64/bin/cmake-gui.exe")
endfunction()

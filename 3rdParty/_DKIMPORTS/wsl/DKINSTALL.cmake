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


############ wsl ############
#dk_validate(Target_Config  "dk_Target_Config()")
# https://learn.microsoft.com/en-us/windows/wsl/
# https://learn.microsoft.com/en-us/windows/wsl/install#install-wsl-command
# https://learn.microsoft.com/en-us/windows/wsl/install-manual

#if(Windows_Host)
#	dk_exec(wsl --install)
#endif()

if(EXISTS "${WSL_EXE}")
	dk_return()
endif()

#if(NOT Windows_Host)
#	dk_disable(wsl)
#	dk_return()
#endif()

if(DEFINED ENV{WSL_DISTRO_NAME})
	dk_set(WSL 1)
endif()

#dk_findProgram(WSL_EXE wsl "$ENV{SystemDrive}/Windows/System32")
if(NOT WSL_EXE)
	if(EXISTS "$ENV{SystemDrive}/Windows/System32/wsl.exe")
		dk_set(WSL_EXE "$ENV{SystemDrive}/Windows/System32/wsl.exe")
	endif()
endif()
dk_assertVar(WSL_EXE)


dk_findProgram(WSLPATH_EXE wslpath)
if(NOT WSLPATH_EXE)
	dk_set(WSLPATH_EXE wslpath)
endif()
dk_assertVar(WSLPATH_EXE)
#execute_process(COMMAND ${WSLPATH_EXE} -m $ENV{DKPOWERSHELL_FUNCTIONS_DIR} OUTPUT_VARIABLE DKPOWERSHELL_FUNCTIONS_DIR)

#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#dk_load(dk_builder)
# https://learn.microsoft.com/en-us/windows/wsl/
# https://learn.microsoft.com/en-us/windows/wsl/install#install-wsl-command
# https://learn.microsoft.com/en-us/windows/wsl/install-manual


#WIN_HOST_dk_command(wsl --install)

if(EXISTS "${WSL_EXE}")
	dk_return()
endif()

#if(NOT WIN_HOST)
#	dk_undepend(wsl)
#	dk_return()
#endif()

if(DEFINED ENV{WSL_DISTRO_NAME})
	dk_set(WSL 1)
endif()

#dk_findProgram(WSL_EXE wsl "C:/Windows/System32")
if(NOT WSL_EXE)
	dk_set(WSL_EXE "C:/Windows/System32/wsl.exe")
endif()
dk_assertVar(WSL_EXE)


dk_findProgram(WSLPATH_EXE wslpath)
if(NOT WSLPATH_EXE)
	dk_set(WSLPATH_EXE wslpath)
endif()
dk_assertVar(WSLPATH_EXE)
#execute_process(COMMAND ${WSLPATH_EXE} -m ${DKPOWERSHELL_FUNCTIONS_DIR} OUTPUT_VARIABLE DKPOWERSHELL_FUNCTIONS_DIR)




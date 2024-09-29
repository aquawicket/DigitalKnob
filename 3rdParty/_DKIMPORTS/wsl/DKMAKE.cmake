#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://learn.microsoft.com/en-us/windows/wsl/
# https://learn.microsoft.com/en-us/windows/wsl/install#install-wsl-command
# https://learn.microsoft.com/en-us/windows/wsl/install-manual


#WIN_HOST_dk_command(wsl --install)

if(DEFINED ENV{WSLENV})
	dk_findProgram(WSL_EXE wsl)
	dk_findProgram(WSLPATH_EXE wslpath)
	#execute_process(COMMAND wslpath -m ${DKPOWERSHELL_FUNCTIONS_DIR} OUTPUT_VARIABLE DKPOWERSHELL_FUNCTIONS_DIR)
endif()
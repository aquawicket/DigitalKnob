#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ wsl ############
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




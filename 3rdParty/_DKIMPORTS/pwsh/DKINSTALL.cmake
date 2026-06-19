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


############ pwsh ############
# https://github.com/PowerShell/PowerShell/releases
# https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-linux-arm32.tar.gz
# https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-linux-arm64.tar.gz
# https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-linux-x64.tar.gz
# https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-osx-arm64.tar.gz
# https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-osx-x64.tar.gz
# https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/PowerShell-7.2.19-win-arm32.zip
# https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/PowerShell-7.2.19-win-arm64.zip
# https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/PowerShell-7.2.19-win-x86.zip
# https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/PowerShell-7.2.19-win-x64.zip

if(EXISTS "${pwsh_exe}")
	return()
endif()

### try pwsh.exe ###
dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
dk_findProgram(pwsh_exe "pwsh.exe" "${DKTOOLS_DIR}")
if(EXISTS "${pwsh_exe}")
	return()
endif()
    
	
### try powershell.exe ###
dk_findProgram(pwsh_exe "pwsh_exe")
if(EXISTS "${pwsh_exe}")
	return()
endif()


dk_fatal("pwsh_exe:${pwsh_exe} NOT FOUND")
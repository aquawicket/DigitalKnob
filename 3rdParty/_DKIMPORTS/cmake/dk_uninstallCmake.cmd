@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"


::####################################################################
::# dk_uninstallCmake()
::#
:dk_uninstallCmake
	call dk_debugFunc 0
	
	call dk_validate HOST_OS "call dk_getHostTriple.cmd"
::  if "%HOST_OS%_%HOST_ARCH%"=="win_arm32"    call dk_set CMAKE_DL
    if "%HOST_OS%_%HOST_ARCH%"=="win_arm64"    set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-arm64.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86"      set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-i386.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64"   set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-x86_64.zip"
    if "%HOST_OS%"=="mac"                      set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-macos-universal.tar.gz"
::	if "%HOST_OS%"=="mac"                      set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-macos10.10-universal.tar.gz"
    if "%HOST_OS%_%HOST_ARCH%"=="linux_x86_64" set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-x86_64.tar.gz"
    if "%HOST_OS%_%HOST_ARCH%"=="linux_arm64"  set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-aarch64.tar.gz"
    if not defined CMAKE_DL call dk_error "CMAKE_DL is invalid"
	
	call dk_basename %CMAKE_DL% CMAKE_DL_FILE
	call dk_removeExtension %CMAKE_DL_FILE% CMAKE_DL_NAME
    call dk_convertToCIdentifier %CMAKE_DL_NAME% CMAKE_FOLDER
    call dk_toLower %CMAKE_FOLDER% CMAKE_FOLDER

	call dk_validate DKTOOLS_DIR "call dk_setDKTOOLS_DIR"
	set "CMAKE=%DKTOOLS_DIR%\%CMAKE_FOLDER%"

	::FIXME: kill pwsh.exe peocess
	call dk_delete "%CMAKE%"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_uninstallCmake
goto:eof
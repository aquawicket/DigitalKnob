@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_uninstallCmake()
::#
:dk_uninstallCmake
	call dk_debugFunc 0
	
	%dk_call% dk_validate DK_HOST_OS                 "%dk_call% dk_getHostTriple.cmd"
::  if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_arm32"    %dk_call% dk_set CMAKE_DL
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_arm64"    set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-arm64.zip"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_x86"      set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-i386.zip"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_x86_64"   set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-x86_64.zip"
    if "%DK_HOST_OS%"=="mac"                         set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-macos-universal.tar.gz"
::	if "%DK_HOST_OS%"=="mac"                         set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-macos10.10-universal.tar.gz"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="linux_x86_64" set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-x86_64.tar.gz"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="linux_arm64"  set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-aarch64.tar.gz"
    if not defined CMAKE_DL                          %dk_call% dk_error "CMAKE_DL is invalid"
	
	::%dk_call% dk_importVariables %CMAKE_DL% rtn_var
	%dk_call% dk_basename %CMAKE_DL% CMAKE_DL_FILE
	%dk_call% dk_removeExtension %CMAKE_DL_FILE% CMAKE_FOLDER
    ::%dk_call% dk_convertToCIdentifier %CMAKE_FOLDER% CMAKE_FOLDER
    %dk_call% dk_toLower %CMAKE_FOLDER% CMAKE_FOLDER
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	set "CMAKE=%DKTOOLS_DIR%\%CMAKE_FOLDER%"

	::FIXME: kill pwsh.exe process
	%dk_call% dk_delete "%CMAKE%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_uninstallCmake
%endfunction%
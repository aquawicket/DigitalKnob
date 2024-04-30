@echo off
call ../../../DKBatch/functions/DK.cmd
call dk_includeGuard

set "CMAKE_DL_WIN_X86=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-i386.zip"
set "CMAKE_DL_WIN_X86_64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-x86_64.zip"
set "CMAKE_DL_WIN_ARM64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-arm64.zip"
set "CMAKE_DL_MAC=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-macos-universal.tar.gz"
::set "CMAKE_DL_MAC=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-macos10.10-universal.tar.gz"
set "CMAKE_DL_LINUX_X86_64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-linux-x86_64.tar.gz"
set "CMAKE_DL_LINUX_ARM64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-linux-aarch64.tar.gz"

::####################################################################
::# dk_InstallCmake()
::#
::#
:dk_InstallCmake () {
	call dk_debugFunc
	
	call dk_validate HOST_OS dk_getHostTriple
	
    if "%HOST_OS%_%HOST_ARCH%"=="win_arm32"    set "CMAKE_DL=%CMAKE_DL_WIN_ARM32%"
    if "%HOST_OS%_%HOST_ARCH%"=="win_arm64"    set "CMAKE_DL=%CMAKE_DL_WIN_ARM64%"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86"      set "CMAKE_DL=%CMAKE_DL_WIN_X86%"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64"   set "CMAKE_DL=%CMAKE_DL_WIN_X86_64%"
    if "%HOST_OS%"=="mac"                      set "CMAKE_DL=%CMAKE_DL_MAC%"
    if "%HOST_OS%_%HOST_ARCH%"=="linux_x86_64" set "CMAKE_DL=%CMAKE_DL_LINUX_X86_64%"
    if "%HOST_OS%_%HOST_ARCH%"=="linux_arm64"  set "CMAKE_DL=%CMAKE_DL_LINUX_ARM64%"
    call dk_debug CMAKE_DL
    
    call dk_getFilename %CMAKE_DL% CMAKE_DL_FILE
	call dk_debug CMAKE_DL_FILE
        
    set CMAKE_FOLDER=%CMAKE_DL_FILE:~0,-4%
    call dk_convertToCIdentifier %CMAKE_FOLDER% CMAKE_FOLDER
    call dk_convertToLowercase %CMAKE_FOLDER% CMAKE_FOLDER
    call dk_debug CMAKE_FOLDER
    
	call dk_validate DKTOOLS_DIR dk_getDKPaths
    set "CMAKE_EXE=%DKTOOLS_DIR%\%CMAKE_FOLDER%\bin\cmake.exe"
    call dk_debug CMAKE_EXE
        
    if exist "%CMAKE_EXE%" goto:eof
       
    echo.   
    echo "Installing cmake . . ."
    ::echo MsiExec.exe /i "%DKDOWNLOAD_DIR%\%CMAKE_DL_FILE%" INSTALL_ROOT="%DKTOOLS_DIR%\%CMAKE_FOLDER%" /qn
    ::MsiExec.exe /i "%DKDOWNLOAD_DIR%\%CMAKE_DL_FILE%" INSTALL_ROOT="%DKTOOLS_DIR%\%CMAKE_FOLDER%" /qn
    call dk_download "%CMAKE_DL%" "%DKDOWNLOAD_DIR%\%CMAKE_DL_FILE%"
	call dk_extract "%DKDOWNLOAD_DIR%\%CMAKE_DL_FILE%" "%DKTOOLS_DIR%"
	set CMAKE_DL_NAME=%CMAKE_DL_FILE:~0,-4%
	rename "%DKTOOLS_DIR%\%CMAKE_DL_NAME%" "%CMAKE_FOLDER%"
	echo %CMAKE_FOLDER%>"%DKTOOLS_DIR%\%CMAKE_FOLDER%\installed"
    
    if NOT exist "%CMAKE_EXE%"   call dk_error "cannot find cmake"
        
    call dk_checkError
goto:eof
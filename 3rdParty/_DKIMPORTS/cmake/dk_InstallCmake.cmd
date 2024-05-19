@echo off
call "../../../DKBatch/functions/DK.cmd"


::####################################################################
::# dk_InstallCmake()
::#
:dk_InstallCmake () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_validate HOST_OS "dk_getHostTriple"
	
::  if "%HOST_OS%_%HOST_ARCH%"=="win_arm32"    call dk_set CMAKE_DL
    if "%HOST_OS%_%HOST_ARCH%"=="win_arm64"    call dk_set CMAKE_DL "https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-arm64.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86"      call dk_set CMAKE_DL "https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-i386.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64"   call dk_set CMAKE_DL "https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-x86_64.zip"
    if "%HOST_OS%"=="mac"                      call dk_set CMAKE_DL "https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-macos-universal.tar.gz"
::	if "%HOST_OS%"=="mac"                      call dk_set CMAKE_DL "https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-macos10.10-universal.tar.gz"
    if "%HOST_OS%_%HOST_ARCH%"=="linux_x86_64" call dk_set CMAKE_DL "https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-linux-x86_64.tar.gz"
    if "%HOST_OS%_%HOST_ARCH%"=="linux_arm64"  call dk_set CMAKE_DL "https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-linux-aarch64.tar.gz"
    
    call dk_getFilename %CMAKE_DL% CMAKE_DL_FILE
	call dk_removeExtension %CMAKE_DL_FILE% CMAKE_DL_NAME
    call dk_convertToCIdentifier %CMAKE_DL_NAME% CMAKE_FOLDER
    call dk_convertToLowercase %CMAKE_FOLDER% CMAKE_FOLDER
	call dk_validate DKTOOLS_DIR "dk_getDKPaths"
    call dk_set CMAKE_EXE "%DKTOOLS_DIR%\%CMAKE_FOLDER%\bin\cmake.exe"
        
    if exist "%CMAKE_EXE%" goto:eof
       
    call dk_info " "
    call dk_info "Installing CMake . . ."
    ::echo MsiExec.exe /i "%DKDOWNLOAD_DIR%\%CMAKE_DL_FILE%" INSTALL_ROOT="%DKTOOLS_DIR%\%CMAKE_FOLDER%" /qn
    ::MsiExec.exe /i "%DKDOWNLOAD_DIR%\%CMAKE_DL_FILE%" INSTALL_ROOT="%DKTOOLS_DIR%\%CMAKE_FOLDER%" /qn
    call dk_download "%CMAKE_DL%" "%DKDOWNLOAD_DIR%\%CMAKE_DL_FILE%"
	call dk_smartExtract "%DKDOWNLOAD_DIR%\%CMAKE_DL_FILE%" "%DKTOOLS_DIR%\%CMAKE_FOLDER%"
	::echo %CMAKE_FOLDER%>"%DKTOOLS_DIR%\%CMAKE_FOLDER%\installed"
    
    if NOT exist "%CMAKE_EXE%"  call dk_error "cannot find cmake"
        
    call dk_checkError
goto:eof
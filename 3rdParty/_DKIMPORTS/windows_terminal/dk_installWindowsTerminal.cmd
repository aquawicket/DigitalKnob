@echo off
call ../../../DKBatch/functions/DK.cmd

::####################################################################
::# dk_installWindowsTerminal()
::#
::#     https://github.com/microsoft/terminal
::# 
:dk_installWindowsTerminal
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	
	call dk_validate HOST_OS "call dk_getHostTriple"
	if "%HOST_OS%_%HOST_ARCH%"=="win_arm64"   call dk_set WINDOWS_TERMINAL_DL "https://github.com/microsoft/terminal/releases/download/v1.20.11381.0/Microsoft.WindowsTerminal_1.20.11381.0_arm64.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86"     call dk_set WINDOWS_TERMINAL_DL "https://github.com/microsoft/terminal/releases/download/v1.20.11381.0/Microsoft.WindowsTerminal_1.20.11381.0_x86.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64"  call dk_set WINDOWS_TERMINAL_DL "https://github.com/microsoft/terminal/releases/download/v1.20.11381.0/Microsoft.WindowsTerminal_1.20.11381.0_x64.zip"
	if not defined WINDOWS_TERMINAL_DL call dk_error "WINDOWS_TERMINAL_DL is invalid"
	
	call dk_getBasename %WINDOWS_TERMINAL_DL% WINDOWS_TERMINAL_DL_FILE
	call dk_removeExtension %WINDOWS_TERMINAL_DL_FILE% WINDOWS_TERMINAL_FOLDER
	call dk_convertToCIdentifier %WINDOWS_TERMINAL_FOLDER% WINDOWS_TERMINAL_FOLDER
	call dk_toLower %WINDOWS_TERMINAL_FOLDER% WINDOWS_TERMINAL_FOLDER
	call dk_validate DKTOOLS_DIR "call dk_getDKPaths"
	call dk_set WINDOWS_TERMINAL "%DKTOOLS_DIR%\%WINDOWS_TERMINAL_FOLDER%"
	call dk_set WINDOWS_TERMINAL_EXE "%WINDOWS_TERMINAL%\wt.exe"
	
	if exist "%WINDOWS_TERMINAL_EXE%" goto:windows_terminal_installed
	call dk_echo   
    call dk_info "Installing Windows Terminal . . ."
    call dk_download %WINDOWS_TERMINAL_DL%
    call dk_smartExtract "%DKDOWNLOAD_DIR%\%WINDOWS_TERMINAL_DL_FILE%" "%WINDOWS_TERMINAL%"
	if NOT exist "%WINDOWS_TERMINAL_EXE%" call dk_error "cannot find wt.exe"
	:windows_terminal_installed
	
	:: install via CMake
	::	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	::	call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/windows_terminal/DKMAKE.cmake')" "WINDOWS_TERMINAL_EXE"
	::	call dk_printVar WINDOWS_TERMINAL_EXE
goto:eof






::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_installWindowsTerminal
goto:eof


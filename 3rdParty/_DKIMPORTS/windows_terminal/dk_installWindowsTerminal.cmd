@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installWindowsTerminal()
::#
::#     https://github.com/microsoft/terminal
::# 
:dk_installWindowsTerminal
	call dk_debugFunc 0	
	
	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
	if defined win_arm64_host   set "WINDOWS_TERMINAL_DL=https://github.com/microsoft/terminal/releases/download/v1.20.11381.0/Microsoft.WindowsTerminal_1.20.11381.0_arm64.zip"
    if defined win_x86_host     set "WINDOWS_TERMINAL_DL=https://github.com/microsoft/terminal/releases/download/v1.20.11381.0/Microsoft.WindowsTerminal_1.20.11381.0_x86.zip"
    if defined win_x86_64_host  set "WINDOWS_TERMINAL_DL=https://github.com/microsoft/terminal/releases/download/v1.20.11381.0/Microsoft.WindowsTerminal_1.20.11381.0_x64.zip"
	if not defined WINDOWS_TERMINAL_DL %dk_call% dk_error "WINDOWS_TERMINAL_DL is invalid"
	
	%dk_call% dk_basename %WINDOWS_TERMINAL_DL% WINDOWS_TERMINAL_DL_FILE
	%dk_call% dk_removeExtension %WINDOWS_TERMINAL_DL_FILE% WINDOWS_TERMINAL_FOLDER
	::%dk_call% dk_convertToCIdentifier %WINDOWS_TERMINAL_FOLDER% WINDOWS_TERMINAL_FOLDER
	%dk_call% dk_toLower %WINDOWS_TERMINAL_FOLDER% WINDOWS_TERMINAL_FOLDER
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	%dk_call% dk_set WINDOWS_TERMINAL_DIR "%DKTOOLS_DIR%\%WINDOWS_TERMINAL_FOLDER%"
	
	
	%dk_call% dk_set WINDOWS_TERMINAL_EXE "%WINDOWS_TERMINAL_DIR%\wt.exe"
	if exist "%WINDOWS_TERMINAL_EXE%" goto:windows_terminal_installed
	%dk_call% dk_echo   
    %dk_call% dk_info "Installing Windows Terminal . . ."
    %dk_call% dk_download %WINDOWS_TERMINAL_DL%
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DIGITALKNOB_DIR"
    %dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%\%WINDOWS_TERMINAL_DL_FILE%" "%WINDOWS_TERMINAL_DIR%"
	if NOT exist "%WINDOWS_TERMINAL_EXE%" %dk_call% dk_error "cannot find wt.exe"
	:windows_terminal_installed

%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_installWindowsTerminal
%endfunction%


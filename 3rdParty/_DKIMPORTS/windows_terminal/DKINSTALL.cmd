@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
::#     https://github.com/microsoft/terminal
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0	
	
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	if defined Windows_Arm64_Host   (set "WINDOWS_TERMINAL_IMPORT=%Windows_Terminal_Windows_Arm64_Import%")
    if defined Windows_X86_Host     (set "WINDOWS_TERMINAL_IMPORT=%Windows_Terminal_Windows_X86_Import%")
    if defined Windows_X86_64_Host  (set "WINDOWS_TERMINAL_IMPORT=%Windows_Terminal_Windows_X86_64_Import%")
	%dk_call% dk_assertVar WINDOWS_TERMINAL_IMPORT
	
::	%dk_call% dk_basename %WINDOWS_TERMINAL_IMPORT% WINDOWS_TERMINAL_IMPORT_FILE
::	%dk_call% dk_removeExtension %WINDOWS_TERMINAL_IMPORT_FILE% WINDOWS_TERMINAL_FOLDER
::	::%dk_call% dk_convertToCIdentifier %WINDOWS_TERMINAL_FOLDER% WINDOWS_TERMINAL_FOLDER
::	%dk_call% dk_toLower %WINDOWS_TERMINAL_FOLDER% WINDOWS_TERMINAL_FOLDER
::	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
::	%dk_call% dk_set WINDOWS_TERMINAL "%DKTOOLS_DIR%/%WINDOWS_TERMINAL_FOLDER%"
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables %WINDOWS_TERMINAL_IMPORT% ROOT %DKTOOLS_DIR%
	%dk_call% dk_assertVar WINDOWS_TERMINAL
	
	set "WINDOWS_TERMINAL_EXE=%WINDOWS_TERMINAL%/wt.exe"
	if exist "%WINDOWS_TERMINAL_EXE%" (%return%)
	
	%dk_call% dk_echo  
    %dk_call% dk_info "Installing Windows Terminal . . ."
    %dk_call% dk_download %WINDOWS_TERMINAL_IMPORT%
    %dk_call% dk_smartExtract "%dk_download%" "%WINDOWS_TERMINAL%"
	%dk_call% dk_assertFile "%WINDOWS_TERMINAL_EXE%"

%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%


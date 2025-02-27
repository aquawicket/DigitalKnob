@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::dk_findProgram(<VAR> name [path1 path2 ...])
::#
::#
:dk_findProgram
setlocal enableDelayedExpansion
    %dk_call% dk_debugFunc 2 9 
 
    set "VAR=%~1"
    set "VAL=!%VAR%!"
	if exist "%VAL%" %dk_call% dk_debug "already FOUND %VAR% at %VAL%" && %return%
	
	set "name=%~2"
	if "%~3" neq "" (
		set "pattern=%~3"
		set "pattern=!pattern:/=\!"
		set "recursive=/R"
	) else (
		set "pattern="
		set "recursive="
	)
    
	%dk_call% dk_commandToVariable where %recursive% %pattern% %name%
	
    endlocal & (
		rem set "dk_findProgram=%dk_commandToVariable%"
		set "%~1=%dk_commandToVariable:\=/%"
		%dk_call% dk_assertPath "%~1"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_findProgram POWERSHELL_EXE "powershell.exe"
    %dk_call% dk_printVar POWERSHELL_EXE
    
    %dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
    %dk_call% dk_findProgram POWERSHELL_EXE "pwsh.exe" "%DKTOOLS_DIR%"
	
	%dk_call% dk_findProgram CMD_EXE "cmd.exe" "C:/Windows/System32"
	%dk_call% dk_printVar CMD_EXE
	%dk_call% dk_findProgram CMD_EXE "cmd.exe"
	%dk_call% dk_printVar CMD_EXE
%endfunction%

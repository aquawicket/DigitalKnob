@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL
::#
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_import APP
	
	if "%Host_Os%" equ "Windows" ( 
		%dk_call% dk_set VSCODE_EXE "%PLUGIN.Install.Path%/Code.exe"
	) else ( 
		%dk_call% dk_set VSCODE_EXE "%PLUGIN.Install.Path%/code"
	)	
	%dk_call% dk_assertPath "%VSCODE_EXE%"
	
	%dk_call% dk_depend vscode/fileAssoc
%endfunction%

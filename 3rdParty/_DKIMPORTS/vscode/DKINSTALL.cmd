@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL
::#
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_import APP
	
	if /i "%Host_Os%" equ "Windows" ( 
		%dk_call% dk_set vscode_exe "%PLUGIN_Install_Path%/Code.exe"
	) else ( 
		%dk_call% dk_set vscode_exe "%PLUGIN_Install_Path%/code"
	)	
	%dk_call% dk_assertPath "%vscode_exe%"
	
	%dk_call% dk_depend vscode/fileAssoc
%endfunction%

@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_import APP
	
	%dk_call% dk_validate Host_Os "%dk_call% dk_Host_Os"
	if /i "%Host_Os%" equ "Windows" ( 
		%dk_call% dk_set pwsh_exe "%pwsh_Install_Path%/pwsh.exe"
	) else ( 
		%dk_call% dk_set pwsh_exe "%pwsh_Install_Path%/pwsh"
	)	
	%dk_call% dk_assertPath "%pwsh_exe%"
	%dk_call% dk_firewallAllow "%pwsh_exe%"

	if EXIST "%pwsh_exe%" (%dk_call% dk_success "pwsh install complete") else (%dk_call% dk_error "pwsh install failed")
	pause
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% DKINSTALL
%endfunction%


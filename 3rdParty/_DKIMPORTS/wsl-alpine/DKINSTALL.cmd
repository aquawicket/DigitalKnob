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
	
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	set "WSL_ALPINE_IMPORT=!Wsl_Alpine_%Host_Tuple%_Import!"
	%dk_call% dk_assertVar WSL_ALPINE_IMPORT

	%dk_call% dk_depend wsl
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables %WSL_ALPINE_IMPORT% ROOT %DKTOOLS_DIR%
	
	if EXIST "%LAUNCHER_IMPORT_FILE%" (%return%)
	%dk_call% dk_echo  
    %dk_call% dk_info "Installing Alpine Linux . . ."
	%dk_call% dk_download "%WSL_ALPINE_IMPORT%"
	%dk_call% dk_mkdir "%WSL_ALPINE%"
	%dk_call% dk_basename "%WSL_ALPINE_IMPORT%"
	%dk_call% dk_copy "%dk_download%" "%WSL_ALPINE%/%dk_basename%" OVERWRITE
	%dk_call% dk_firewallAllow "%WSL_ALPINE%/%dk_basename%"

	%dk_call% dk_assertPath "%WSL_ALPINE%/%dk_basename%"
	
	::%dk_call% dk_debug "%WSL_ALPINE:/=\%\%dk_basename% config --default-user root"
	%WSL_ALPINE:/=\%\%dk_basename% config --default-user root
	::%dk_call% dk_echo "%WSL_ALPINE:/=\%\%dk_basename%"
	%WSL_ALPINE:/=\%\%dk_basename%

%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%

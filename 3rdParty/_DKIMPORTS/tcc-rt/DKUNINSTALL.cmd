@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKUNINSTALL
::#
:DKUNINSTALL
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
	if NOT defined tcc-rt_Import	(%dk_call% dk_error "tcc-rt_Import is invalid")
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables %tcc-rt_Import% INSTALL_ROOT %DKTOOLS_DIR%
	
	%dk_call% dk_set tcc-rt_exe "%tcc-rt%/tcc.exe"
	if NOT EXIST "%tcc-rt_exe%" (%return%)
	
	:: UNINSTALL
	%dk_call% dk_echo  
    %dk_call% dk_info "UnInstalling tcc-rt . . ."
	"MsiExec.exe" /uninstall {B11E65DB-66DF-4987-9D13-014EFC915DF2} /quiet
	
	if EXIST "%SystemDrive%/Users/Public/Desktop/TCC-RT 32.lnk" (
		%dk_call% dk_delete "%SystemDrive%/Users/Public/Desktop/TCC-RT 32.lnk"
	)
%endfunction%








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKUNINSTALL
%endfunction%

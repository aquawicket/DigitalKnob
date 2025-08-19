@echo off&::###### DK.cmd #########################################################################################################################
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
	if NOT defined TCC_RT_IMPORT	(%dk_call% dk_error "TCC_RT_IMPORT is invalid")
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables %TCC_RT_IMPORT% ROOT %DKTOOLS_DIR%
	
	%dk_call% dk_set TCC_RT_EXE "%TCC_RT%/tcc.exe"
	if NOT EXIST "%TCC_RT_EXE%" (%return%)
	
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

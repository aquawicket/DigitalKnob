@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
	if not defined TCC_RT_IMPORT	(%dk_call% dk_error "TCC_RT_IMPORT is invalid")
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables %TCC_RT_IMPORT% NAME tcc-rt ROOT %DKTOOLS_DIR%
	set "TCC_RT_EXE=%TCC_RT%/tcc.exe"
	
	if exist "%TCC_RT_EXE%" (
		%dk_call% dk_notice "TCC_RT_EXE:%TCC_RT_EXE% already found"
		%return%
	)
	%dk_call% dk_echo  
    %dk_call% dk_info "Installing tcc . . ."
    %dk_call% dk_download %TCC_RT_IMPORT%
   
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%dk_call% dk_basename "%TCC_RT_IMPORT%" TCC_RT_IMPORT_FILE
	
	::%USERPROFILE%\digitalknob\download\tcc-rt.exe /qn APPDIR=%USERPROFILE%\digitalknob\DKTools\tcc-rt
	call "%DKDOWNLOAD_DIR%/%TCC_RT_IMPORT_FILE%" /qn APPDIR="%TCC_RT:/=\%"
	
	
	:: UNINSTALL
	::MsiExec.exe /uninstall {B11E65DB-66DF-4987-9D13-014EFC915DF2} /quiet
	
	
	::if NOT exist "%TCC_RT_EXE%" %dk_call% dk_error "cannot find TCC_RT_EXE:%TCC_RT_EXE%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%

@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
	if NOT defined tcc-rt_Import	(%dk_call% dk_error "tcc-rt_Import is invalid")
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables %tcc-rt_Import% NAME tcc-rt INSTALL_ROOT %DKTOOLS_DIR%
	set "tcc-rt_exe=%tcc-rt%/tcc.exe"
	
	if EXIST "%tcc-rt_exe%" (
		%dk_call% dk_notice "tcc-rt_exe:%tcc-rt_exe% already found"
		%return%
	)
	%dk_call% dk_echo  
    %dk_call% dk_info "Installing tcc . . ."
    %dk_call% dk_download %tcc-rt_Import%
   
	::%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%dk_call% dk_basename "%tcc-rt_Import%" tcc-rt_Import_FILE
	
	::%USERPROFILE%\DigitalKnob\download\tcc-rt.exe /qn APPDIR=%USERPROFILE%\DigitalKnob\DKTools\tcc-rt
	::call "%DKDOWNLOAD_DIR%/%tcc-rt_Import_FILE%" /qn APPDIR="%tcc-rt:/=\%"
	call "%dk_download%" /qn APPDIR="%tcc-rt:/=\%"
	
	
	:: UNINSTALL
	::MsiExec.exe /uninstall {B11E65DB-66DF-4987-9D13-014EFC915DF2} /quiet
	
	
	::if NOT EXIST "%tcc-rt_exe%" %dk_call% dk_error "cannot find tcc-rt_exe:%tcc-rt_exe%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%

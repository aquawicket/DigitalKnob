@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_fileMD5(filepath)
::#
::#
:dk_fileMD5
%setlocal%
	%dk_call% dk_debugFunc 1

	set /a count=1
	for /f "skip=1 delims=:" %%a in ('CertUtil -hashfile "%~1" MD5') do (
	  if !count! equ 1 set "md5=%%a"
	  set/a count+=1
	)
	set "md5=%md5: =%
	
	endlocal & (
		set "dk_fileMD5=%md5%"
	)
%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
 
	%dk_call% dk_fileMD5 "DK.cmd"
	%dk_call% dk_printVar dk_fileMD5
%endfunction%


@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_fileMD5(filepath <rtn_var:optional>)
::#
::#
:dk_fileMD5
%setlocal%
	%dk_call% dk_debugFunc 1 2

	::%dk_call% dk_assertPath "%~1"
	set /a count=1
	for /f "skip=1 delims=:" %%a in ('C:\Windows\System32\certutil.exe -hashfile "%~1" MD5') do (
	  if !count! equ 1 set "dk_fileMD5=%%a"
	  set/a count+=1
	)
	set "dk_fileMD5=%dk_fileMD5: =%
	
	endlocal & (
		set "dk_fileMD5=%dk_fileMD5%"
		if "%~2" neq "" (set "%~2=%dk_fileMD5%")
	)
%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
 
	%dk_call% dk_fileMD5 "C:/Windows/regedit.exe"
	%dk_call% dk_echo "dk_fileMD5 = %dk_fileMD5%"
	
	%dk_call% dk_fileMD5 "DK.cmd" myMD5
	%dk_call% dk_echo "dk_fileMD5 = %dk_fileMD5%"
	%dk_call% dk_echo "myMD5 = %myMD5%"
%endfunction%


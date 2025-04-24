@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# Services/dk_enable(name)
::#
::#
:dk_enable
setlocal
	%dk_call% dk_debugFunc 0
	set "SERVICE_NAME=%~1"   
	  
	reg add HKLM\SYSTEM\CurrentControlSet\Services\%SERVICE_NAME% /t REG_DWORD /v Start /d 3 /f
	sc config "%SERVICE_NAME%" start=auto
	sc start %SERVICE_NAME%
%endfunction%












::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% Services/dk_enable TODO
%endfunction%
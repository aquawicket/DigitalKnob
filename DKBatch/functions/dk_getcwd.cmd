@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKPWD (set "DKPWD=%CD:\=/%")
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################



::##################################################################################
::# dk_getcwd(rtn_var)
::#
::#
:dk_getcwd
	%dk_call% dk_debugFunc 0
	
	set "dk_getcwd=%CD%"
	
	::###### output ######
	endlocal & (
		set "DKPWD=%dk_getcwd%"
		set "dk_getcwd=%dk_getcwd%"
		if "%~1" neq "" (set "%~1=%dk_getcwd%") else (echo %dk_getcwd%)
	)
	
	
	
	
echo %endfunction%
exit /b 0











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	%dk_call% dk_debugFunc 0
	
	::### Result as global variable
	%dk_call% dk_echo
	%dk_call% dk_getcwd
	%dk_call% dk_echo "   dk_getcwd = %dk_getcwd%"
	%dk_call% dk_echo "    DKOLDPWD = %DKOLDPWD%"
	%dk_call% dk_echo "       DKPWD = %DKPWD%"
	
	::### Result as return value
::	%dk_call% dk_echo
::	for /f "usebackq delims=" %%G in (`cmd /c call dk_getcwd`) do set "resultB=%%G"
::	%dk_call% dk_echo "     resultB = %resultB%"
::	%dk_call% dk_echo "   dk_getcwd = %dk_getcwd%"
::	%dk_call% dk_echo "    DKOLDPWD = %DKOLDPWD%"
::	%dk_call% dk_echo "       DKPWD = %DKPWD%"

	::### Result as variable parameter
	%dk_call% dk_echo
	%dk_call% dk_getcwd resultC
	%dk_call% dk_echo "     resultC = %resultC%"
	%dk_call% dk_echo "   dk_getcwd = %dk_getcwd%"
	%dk_call% dk_echo "    DKOLDPWD = %DKOLDPWD%"
	%dk_call% dk_echo "       DKPWD = %DKPWD%"
	
	::### Result as hashtable parameter
	%dk_call% dk_echo
	%dk_call% dk_getcwd resultD.data
	%dk_call% dk_echo "resultD.data = %resultD.data%"
	%dk_call% dk_echo "   dk_getcwd = %dk_getcwd%"
	%dk_call% dk_echo "    DKOLDPWD = %DKOLDPWD%"
	%dk_call% dk_echo "       DKPWD = %DKPWD%"
%endfunction%

@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################



rem ##################################################################################
rem # dk_getcwd(rtn_var)
rem #
rem #
:dk_getcwd
	
	if NOT defined DKPWD (set "DKPWD=%CD:\=/%")
	set "dk_getcwd=%CD%"
	
	:return
	endlocal & (
		set "DKPWD=%dk_getcwd%"
		set "dk_getcwd=%dk_getcwd%"
		if "%~1" neq "" (set "%~1=%dk_getcwd%") else (echo %dk_getcwd%)
	)
	
	
	
	
echo %endfunction%
exit /b 0











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	
	rem ### Result as global variable
	%dk_call% dk_echo
	%dk_call% dk_getcwd
	%dk_call% dk_echo "   dk_getcwd = %dk_getcwd%"
	%dk_call% dk_echo "    DKOLDPWD = %DKOLDPWD%"
	%dk_call% dk_echo "       DKPWD = %DKPWD%"
	
	rem ### Result as return value
rem	%dk_call% dk_echo
rem	for /f "usebackq delims=" %%G in (`cmd /c call dk_getcwd`) do set "resultB=%%G"
rem	%dk_call% dk_echo "     resultB = %resultB%"
rem	%dk_call% dk_echo "   dk_getcwd = %dk_getcwd%"
rem	%dk_call% dk_echo "    DKOLDPWD = %DKOLDPWD%"
rem	%dk_call% dk_echo "       DKPWD = %DKPWD%"

	rem ### Result as variable parameter
	%dk_call% dk_echo
	%dk_call% dk_getcwd resultC
	%dk_call% dk_echo "     resultC = %resultC%"
	%dk_call% dk_echo "   dk_getcwd = %dk_getcwd%"
	%dk_call% dk_echo "    DKOLDPWD = %DKOLDPWD%"
	%dk_call% dk_echo "       DKPWD = %DKPWD%"
	
	rem ### Result as hashtable parameter
	%dk_call% dk_echo
	%dk_call% dk_getcwd resultD.data
	%dk_call% dk_echo "resultD.data = %resultD.data%"
	%dk_call% dk_echo "   dk_getcwd = %dk_getcwd%"
	%dk_call% dk_echo "    DKOLDPWD = %DKOLDPWD%"
	%dk_call% dk_echo "       DKPWD = %DKPWD%"
%endfunction%

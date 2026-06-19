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


rem ################################################################################
rem # dk_getGlobal(name)
rem #
rem #
:dk_getGlobal
%setlocal%
	rem for /F "tokens=1,2* skip=2" %%a in ('%SystemRoot%\System32\reg.exe QUERY HKCU\Environment /v %~1 2^>nul') do if /i "%%a" equ "%~1" endlocal & set "%1=%%c"
	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	set /p value=< "%DKCACHE_DIR%\%~1.var"
	
	endlocal & (
		set "%~1=%value%"
	)
%endfunction%


rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_echo "initial value of myGlobalVar"
	%dk_call% dk_echo "myGlobalVar = %myGlobalVar%"

	echo.
	%dk_call% dk_echo "calling dk_getGlobal"
	%dk_call% dk_getGlobal myGlobalVar
	%dk_call% dk_echo "myGlobalVar = %myGlobalVar%"

%endfunction%

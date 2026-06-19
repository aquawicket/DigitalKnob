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


rem ##############################################################################
rem # dk_isFunction(name) -> rtn_var
rem #
rem # Test if a string is a function name
rem #
rem # @name  		- The name to test
rem # @rtn_var:   - True if the string is the name of a function, False if otherwise.
rem #
rem # https://stackoverflow.com/a/85932/688352
rem #
:dk_isFunction
%setlocal%
    %ComSpec% /c "(help %~1 > nul || exit 0) && where %~1 > nul 2> nul"
    if %ERRORLEVEL% equ 0 (
        set "dk_isFunction=0"
    ) else (
		set "dk_isFunction=1"
	)
	
	:return
	endlocal & (
		set "dk_isFunction=%dk_isFunction%"
		if "%~2" neq "" (set "%~2=%dk_isFunction%")
    ) 
	exit /b %dk_isFunction%
%endfunction%









rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
    %dk_call% dk_isFunction "NotAFunction" && %dk_call% dk_info "'NotAFunction' is a function" || %dk_call% dk_info "'NotAFunction' is NOT a function"
	%dk_call% dk_isFunction "DKTEST"       && %dk_call% dk_info "'DKTEST' is a function"       || %dk_call% dk_info "'DKTEST' is NOT a function"
%endfunction%

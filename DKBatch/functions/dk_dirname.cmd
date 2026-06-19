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
rem # dk_dirname(<pathname>, <rtn_var>:optional)
rem #
rem #   Returns a parent directory's path
rem #
rem #   Reference: https://en.wikipedia.org/wiki/Dirname
rem #
:dk_dirname
%setlocal%

    set "pathname=%1"
    set "pathname=%pathname:"=%"
	set "pathname=%pathname:/=\%"
	
	if "%pathname:~-1%" equ "\" set "pathname=%pathname:~0,-1%"
    for %%Z in ("%pathname%") do set "dk_dirname=%%~dpZ"
	if "%dk_dirname:~-1%" equ "\" set "dk_dirname=%dk_dirname:~0,-1%"
	
	
	:return
	endlocal & (
		set "dk_dirname=%dk_dirname%"
		if "%~2" neq "" (set "%~2=%dk_dirname%")
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_set myPath "%SystemRoot:\=/%/System32"
    %dk_call% dk_dirname "%myPath%"
    %dk_call% dk_echo "%myPath%: dirname = '%dk_dirname%'"
	
	%dk_call% dk_set myPath "%SystemRoot:\=/%/System32/"
    %dk_call% dk_dirname "%myPath%"
    %dk_call% dk_echo "%myPath%: dirname = '%dk_dirname%'"
	
	%dk_call% dk_set myPath "%SystemRoot:\=/%/System32"
    %dk_call% dk_dirname "%myPath%"
    %dk_call% dk_echo "%myPath%: dirname = '%dk_dirname%'"
	
	%dk_call% dk_set myPath "%SystemRoot:\=/%/System32/"
    %dk_call% dk_dirname "%myPath%"
    %dk_call% dk_echo "%myPath%: dirname = '%dk_dirname%'"
	
	rem FIXME
	%dk_call% dk_set myPath "/home/aquawicket/docs/."
    %dk_call% dk_dirname "%myPath%"
    %dk_call% dk_echo "%myPath%: dirname = '%dk_dirname%'"
	
	%dk_call% dk_set myPath "/home/aquawicket/docs/"
    %dk_call% dk_dirname "%myPath%"
    %dk_call% dk_echo "%myPath%: dirname = '%dk_dirname%'"
	
	%dk_call% dk_set myPath "base.wiki"
    %dk_call% dk_dirname "%myPath%"
    %dk_call% dk_echo "%myPath%: dirname = '%dk_dirname%'"
	
	rem FIXME
	rem %dk_call% dk_set myPath "/"
    rem %dk_call% dk_dirname "%myPath%"
    rem %dk_call% dk_echo "%myPath%: dirname = '%dk_dirname%'"
%endfunction%

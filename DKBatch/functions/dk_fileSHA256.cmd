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


rem ############################################################################
rem # dk_fileSHA256(filepath)
rem #
rem #
:dk_fileSHA256
%setlocal%

	set /a count=1
	for /f "skip=1 delims=:" %%a in ('CertUtil -hashfile "%~1" SHA256') do (
	  if !count! equ 1 set "md5=%%a"
	  set/a count+=1
	)
	set "md5=%md5: =%
	
	endlocal & (
		set "dk_fileSHA256=%md5%"
	)
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
 
	%dk_call% dk_fileSHA256 "DK.cmd"
	%dk_call% dk_printVar dk_fileSHA256
%endfunction%


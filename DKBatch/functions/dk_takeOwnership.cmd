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


rem ####################################################################
rem # dk_takeOwnership(path)
rem #
rem #
:dk_takeOwnership
%setlocal%
	
	set "_path_=%~1"
	set "_path_=%_path_:/=\%"

	rem %dk_call% dk_validate powershell.exe %dk_call% dk_depend powershell.exe
	rem "%powershell.exe%" -windowstyle hidden -command "$Y = ($null | choice).Substring(1,1); Start-Process cmd -ArgumentList ('/c takeown /f \"%_path_%\" /r /d ' + $Y + ' && icacls \"%path%\" /grant *S-1-3-4:F /t /c /l /q & pause') -Verb runAs"
	%ComSpec% /c "%SystemRoot%\System32\takeown.exe" /f "%_path_%"

%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_takeOwnership "%DIGITALKNOB_DIR%"
%endfunction%

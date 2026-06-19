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
rem # dk_folderName(<path> rtn_var)
rem #
rem #
:dk_folderName
%setlocal%

	for %%a in ("%~1") do for %%b in ("%%~dpa\.") do set "dk_folderName=%%~nxb"
	
	rem ### return ###
	endlocal & (
		set "dk_folderName=%dk_folderName%"
		if "%~2" neq "" (set "%~2=%dk_folderName%")
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_folderName "C:/Windows/System32"
	%dk_call% dk_echo "dk_folderName = %dk_folderName%"
	
	%dk_call% dk_folderName "C:/Windows/System32" myFolderName
	%dk_call% dk_echo "dk_folderName = %dk_folderName%"
	%dk_call% dk_echo "myFolderName = %myFolderName%"
%endfunction%

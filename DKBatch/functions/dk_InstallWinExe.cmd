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


rem ##############################################################################################################
rem # dk_InstallWinExe(exePath)
rem #
rem #  https://superuser.com/questions/1214490/what-prevents-copied-renamed-moved-notepad-exe-from-running-in-some-windows-edit
:dk_InstallWinExe
%setlocal%

	set "exe_path=%~1"
	echo installing %exe_path:/=\% . . .
	for %%G in ("%exe_path:/=\%") do (set "exe_filename=%%~nxG")
	
	%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
	set "destination=%DKTOOLS_DIR%/%exe_filename%"
	mkdir "%destination:/=\%\En-us"
	
	rem # Copy .exe to %destination%
	copy "%exe_path:/=\%" "%destination:/=\%\%exe_filename%"

	rem # Find the .mui file and copy to %destination%\En-us
	rem echo Searching for %exe_filename%.mui
	rem for /F "tokens=*" %%G IN ('where /r %SystemRoot%\System32\En-us %exe_filename%.mui') do (set "exe_mui_path=%%~G")
	rem echo exe_mui_path = %exe_mui_path%
	copy "%SystemRoot%\System32\En-us\%exe_filename%.mui" "%destination:/=\%\En-us\%exe_filename%.mui"
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_InstallWinExe "%SystemRoot:\=/%/System32/cmd.exe"
	%dk_call% dk_InstallWinExe "%SystemRoot:\=/%/notepad.exe"
	%dk_call% dk_InstallWinExe "%SystemRoot:\=/%/System32/find.exe"
%endfunction%
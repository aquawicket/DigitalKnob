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


rem MajorGeeks.Com
rem https://www.majorgeeks.com/content/page/how_to_clear_all_event_logs_in_event_viewer_in_windows.html

FOR /F "tokens=1,2*" %%V IN ('bcdedit') DO SET adminTest=%%V
if (%adminTest%)==(Access) goto noAdmin
for /F "tokens=*" %%G in ('wevtutil.exe el') DO (call :do_clear "%%G")
echo.

echo All Event Logs have been cleared!
%endfunction%

:do_clear
echo clearing %1
rem https://www.tenforums.com/performance-maintenance/100547-failed-clear-event-logs.html
wevtutil sl Microsoft-Windows-LiveId/Operational /ca:O:BAG:SYD:(A;;0x1;;;SY)(A;;0x5;;;BA)(A;;0x1;;;LA)
wevtutil sl Microsoft-Windows-LiveId/Analytic /ca:O:BAG:SYD:(A;;0x1;;;SY)(A;;0x5;;;BA)(A;;0x1;;;LA)
wevtutil.exe cl %1
%endfunction%

:noAdmin
echo Danger, Will Robinson!
echo This bat file must be run as administrator
echo Press the Enter key to close this window
echo Right-click on "Clear All Event Logs.bat" and select "Run as administrator" 
pause >nul
%endfunction%
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


:: MajorGeeks.Com
:: https://www.majorgeeks.com/content/page/how_to_clear_all_event_logs_in_event_viewer_in_windows.html

FOR /F "tokens=1,2*" %%V IN ('bcdedit') DO SET adminTest=%%V
IF (%adminTest%)==(Access) goto noAdmin
for /F "tokens=*" %%G in ('wevtutil.exe el') DO (call :do_clear "%%G")
echo.

echo All Event Logs have been cleared!
%endfunction%

:do_clear
echo clearing %1
wevtutil.exe cl %1
%endfunction%

:noAdmin
echo Danger, Will Robinson!
echo This bat file must be run as administrator 
echo Press the Enter key to close this window 
echo Right-click on "Clear All Event Logs.bat" and select "Run as administrator"  
pause >nul
%endfunction%
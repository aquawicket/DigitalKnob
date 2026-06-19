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
rem # dk_timeoutCall(seconds, command)
rem #
rem #    Call a command after timeout
rem #
:dk_timeoutCall
%setlocal%

	rem set seconds=%~2
	rem set command=%~1

	rem ### Carrige Return ###
	for /F %%# in ('copy /Z "%~dpf0" nul') do set "CR=%%#"
	
	rem ### choice.exe ###
	%dk_call% dk_validate choice.exe %dk_call% dk_findFile choice.exe
	
	:Timer
    for /L %%i in (%~1 -1 1) do (
		<nul set /p ".= calling '%~2' in  %%i  Seconds [R]estart Timer [C]ancel [N]o wait !CR!"
        for /F "delims=" %%G in ('%choice.exe% /T 1 /N /C:CRNW /D W') do (
			if %%G==R (goto :Timer)
			%clearerror%
			if %%G==N (goto :EndTimer)
            if %%G==C (
				call :ClearLine
				%return%
			)
            
        )
    )
	:EndTimer
	call :ClearLine
	%~2
%endfunction%

:ClearLine
	<nul set /p ".=%invisible%                                                                                                              !CR!%clr%"
exit /b 0 




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
    %dk_call% dk_timeoutCall 5 "ver"
	%dk_call% dk_timeoutCall 5 "dir"
	%dk_call% dk_timeoutCall 5 "echo the date is %date%"
%endfunction%

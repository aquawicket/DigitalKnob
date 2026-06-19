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
rem # dk_killProcess(process)
rem #     Kill a process by process name
rem #
rem #     process:  the name of the task to kill.  I.E. cale.exe
rem #
rem #     Example:  %dk_call% dk_killProcess iexplore.exe
rem #   
:dk_killProcess
%setlocal%
	
    set "process=%~1"

    %dk_call% dk_processIsRunning %process% || exit /b 0

	%dk_call% dk_validate tasklist.exe %dk_call% dk_findFile tasklist.exe
    "%tasklist.exe:/=\%" /fi "imagename eq %process%" |find ":" >nul
    if errorlevel 1 taskkill /f /im "%process%"
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
	rem ### Test 1
	%dk_call% dk_killProcess gpg-agent.exe
	
	rem ### Test 2
	%dk_call% dk_echo "Opening mspaint.exe . . ."
    start mspaint.exe
	%dk_call% dk_echo "waiting 3 seconds . . ."
    %dk_call% dk_sleep 3
	%dk_call% dk_echo "Killing mspaint.exe . . ."
    %dk_call% dk_killProcess mspaint.exe
	
%endfunction%

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
rem # dk_fullscreen()
rem #
rem #
:dk_toggleFullscreen
%setlocal%

	rem ### Methood 1 - mshta javascript call
	%dk_call% dk_validate mshta.exe %dk_call% dk_findFile mshta.exe
	title batchfs
	@"%mshta.exe:/=\%" "javascript:var WshShell = new ActiveXObject("WScript.Shell");WshShell.AppActivate("batchfs");WshShell.SendKeys("{F11}");close();"
	set dk_toggleFullscreen=%errorlevel%
	
	
	rem	### dk_fullscreen_js ###
rem	%dk_call% dk_validate DKJAVASCRIPT_FUNCTIONS_DIR %dk_call% dk_DKBRANCH_DIR
rem	for /F "usebackq delims=" %%r in ("%DKJAVASCRIPT_FUNCTIONS_DIR%/dk_fullscreen.js") do (
rem		set dk_fullscreen_js=!dk_fullscreen_js!%%r
rem	)
rem for /f "usebackq delims=" %%i in (`@"%mshta.exe%" "javascript:%dk_fullscreen_js%") do set "dk_fullscreen=%%i

	
	
	:return
	endlocal & (
		set "dk_toggleFullscreen=%dk_toggleFullscreen%"
		if "%~1" neq "" (
			set "%~1=%dk_toggleFullscreen%"
		)
	)
%endfunction%








rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_toggleFullscreen
	%dk_call% dk_debug "dk_toggleFullscreen = %dk_toggleFullscreen%"
	
    %dk_call% dk_sleep 3
	
    %dk_call% dk_toggleFullscreen
	%dk_call% dk_debug "dk_toggleFullscreen = %dk_toggleFullscreen%"
%endfunction%

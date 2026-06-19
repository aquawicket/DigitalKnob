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
rem # dk_consoleTitle(pid, SET)
rem #
:dk_consoleTitle
%setlocal%
	
	set "dk_consolePID=%~1"
	
	rem ### SET ###
	if "%~2" neq "" (
		set "dk_consoleTitle=%~2"
		title !dk_consoleTitle!
		
	rem ### GET ###	
	) else (
		%dk_call% dk_validate tasklist.exe %dk_call% dk_findFile tasklist.exe
		%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
		for /f "tokens=1-10 Delims=," %%a IN ('!tasklist.exe:/=\! /v /fo csv ^| !findstr.exe! /i "%dk_consolePID%"') Do (
			rem set "Image_Name=%%~a"
			rem	set "dk_consoleTitle=%%~b"
			rem set "Session_Name=%%~c"
			rem set "Session#=%%~d"
			rem set "Mem_Usage=%%~e,%%~f"
			rem set "Status=%%~g"
			rem set "User_Name=%%~h"
			rem set "CPU Time=%%~i"
				set "dk_consoleTitle=%%~j"
		)
	)
	
	:return
	endlocal & (
		set "dk_consoleTitle=%dk_consoleTitle%"
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_consolePID
	%dk_call% dk_consoleTitle %dk_consolePID%
	%dk_call% dk_debug "dk_consoleTitle = %dk_consoleTitle%"
	
	%dk_call% dk_consoleTitle %dk_consolePID% "Test Setting the Console Title"
	%dk_call% dk_debug "dk_consoleTitle = %dk_consoleTitle%"
%endfunction%
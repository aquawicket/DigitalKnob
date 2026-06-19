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
rem # dk_consolePID()
rem #
:dk_consolePID
%setlocal%
	
	set "Title=DigitalKnob_%RANDOM%"
	title %Title%
	%dk_call% dk_validate tasklist.exe %dk_call% dk_findFile tasklist.exe
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	for /f "tokens=1-10 Delims=," %%a IN ('%tasklist.exe:/=\% /v /fo csv ^| %findstr.exe% /i "%Title%"') Do (
		rem set "Image_Name=%%~a"
			set "dk_consolePID=%%~b"
		rem set "Session_Name=%%~c"
		rem set "Session#=%%~d"
		rem set "Mem_Usage=%%~e,%%~f"
		rem set "Status=%%~g"
		rem set "User_Name=%%~h"
		rem set "CPU Time=%%~i"
		rem set "Window_Title=%%~j"
	)
	
	echo dk_consolePID = %dk_consolePID%
	endlocal & (
		set "dk_consolePID=%dk_consolePID%"
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_consolePID
	%dk_call% dk_debug "dk_consolePID = %dk_consolePID%"
%endfunction%
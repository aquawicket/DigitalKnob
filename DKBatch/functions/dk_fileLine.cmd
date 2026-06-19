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


rem ############################################################################
rem # dk_fileLine(file linenumber rtn_var:optional)
rem #
rem #	Read a line of a file into a variable.
rem #
:dk_fileLine
%setlocal%
 
	set "_file_=%~f1"
	rem set "linenumber=%~2"

	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	for /f "tokens=*" %%a in ('%findstr.exe:/=\% /n .* "%_file_:/=\%"') do (
		set "FullLine=%%a"
		for /f "tokens=1* delims=:" %%b in ("%%a") do (
			if "%%b" equ "%~2" (
				set "dk_fileLine=!FullLine:*:=!"
				goto:return
			)	
		)
	)
	
	:return
	endlocal & (
		set "dk_fileLine=%dk_fileLine%"
		if "%~3" neq "" (set "%~3=%dk_fileLine%") 
	)
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

rem This is line 57 of dk_fileLine.cmd
rem And this is line 58
rem line 59

	%dk_call% dk_fileLine "%~f0" 57
	echo.!dk_fileLine!
	
	%dk_call% dk_fileLine "%~f0" 58
	echo.!dk_fileLine!
	
	%dk_call% dk_fileLine "%~f0" 59
	echo.!dk_fileLine!
%endfunction%


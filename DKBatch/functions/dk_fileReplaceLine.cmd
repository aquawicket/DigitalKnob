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
rem # dk_fileReplaceLine(<file> <linenum> <newstring>)
rem #
rem #
:dk_fileReplaceLine
setlocal DisableDelayedExpansion

	set "file=%~1"
	set "linenum=%~2"
	set "newstring=%~3"
	
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	<"%file%" >"%file%.tmp~" (
	  for /f "delims=" %%i in ('type "%file%"^|%findstr.exe% /n "^"') do (
		set "line=%%i"
		setlocal EnableDelayedExpansion
		for /f "delims=:" %%j in ("!line!") do if %%j equ %linenum% (
		  echo.!newstring!
		) else (
		  echo.!line:*:=!
		)
		endlocal
	  )
	)
	move /y "%file%.tmp~" "%file%"
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	set "file=dk_fileReplaceLine_TEST.txt"
	
	>%file% ( 
		echo one
		echo two
		echo three
		echo four
		echo five
	)
	
	%dk_call% dk_fileReplaceLine "%file%" 3 "this line was replaced"
%endfunction%


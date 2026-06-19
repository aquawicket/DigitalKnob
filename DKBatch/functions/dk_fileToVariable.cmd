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
rem # dk_fileToVariable
rem #
rem # https://www.dostips.com/forum/viewtopic.php?f=3&t=2128&sid=938ec204d04c1482fc7c39b6a457b052
rem #
:dk_fileToVariable


	rem chcp 65001>nul
	set "_file_=%~1"
	set "dk_fileToVariable="
	set "n="

	if NOT DEFINED CR (for /f %%a in ('copy /Z %ComSpec% nul') do set "CR=%%a")
	if NOT DEFINED LF (set LF=^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

	for /f "usebackq" %%a in (`dir /b/s/a:-d %_file_:/=\%`)  do (
		for /f "usebackq" %%b in (`type %%a ^| find "" /v /c`) do (
			set /a lines+=%%b
		)
	)

	<"%_file_:/=\%" (
	   call :readLoop
	)
	%return%
	:readLoop
		set "line="
		set /p line=
		if not defined n (
			rem (set dk_fileToVariable=0: !line!)
			(set dk_fileToVariable=!line!)
		) else (
			rem (set dk_fileToVariable=!dk_fileToVariable!!CR!!LF!%n%: !line!)
			(set dk_fileToVariable=!dk_fileToVariable!!CR!!LF!!line!)
		)
		rem for /f "tokens=1,2 delims==" %%a in ("!line!") do (echo a=%%a b=%%b)
		set /a n+=1
		if %n% equ %lines% (exit /b 0)
	goto :readLoop
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	set "file=%~f0"
	set "filecopy=%~dpn0_COPY.cmd"
	call :dk_fileToVariable "%file%"

	rem ### Print variable
	echo ------------------------ %file% ----------------------------
	echo !dk_fileToVariable!
	echo ----------------------------------------------------------

	rem ### Write variable back to file
	>"%filecopy%" echo !dk_fileToVariable!
%endfunction%

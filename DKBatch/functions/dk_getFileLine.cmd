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
rem # dk_getFileLine(filepath, match_string)
rem #
rem #
:dk_getFileLine
%setlocal%

	set "_filepath_=%~f1"
	set "_filepath_=%_filepath_:/=\%"
	rem %dk_call% dk_assertPath "%_filepath_%"
   
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
    for /f "delims=:" %%a in ('%findstr.exe% /n /c:"%~2" "%_filepath_%"') do (
		if "!line!" equ "" (
			set "line=%%a"
		) else (
			set "line=!line!;%%a"
		)
	)

	endlocal & set "dk_getFileLine=%line%"
rem DEBUG
rem	echo %line%: '%~2'
%endfunction%


rem FIND THIS LINE

rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

rem    %dk_call% dk_getFileLine "../../README.md" "How to build"
	%dk_call% dk_getFileLine "%~0" ":: FIND THIS LINE"
	echo dk_getFileLine = %dk_getFileLine%
%endfunction%

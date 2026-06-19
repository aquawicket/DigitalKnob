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


rem ##############################################################################
rem # dk_hasLabel(file label)
rem #
rem # Test if a string is a dk_hasLabel name
rem #
rem # @file   - The file to search.
rem # @label  - The name of the label to search for.
rem # @return	- 0 if the string is the name of a dk_hasLabel, 1 if otherwise.
rem #
:dk_hasLabel
%setlocal%

	set "dk_hasLabel=1"
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	%findstr.exe% /ri /c:"^ *:%~2 " /c:"^ *:%~2$" "%~1" >nul 2>nul && (
        set "dk_hasLabel=0"
    )
   
	:return
	endlocal & (
		set "dk_hasLabel=%dk_hasLabel%"
		set "findstr.exe=%findstr.exe%"
	)

    exit /b %dk_hasLabel%
%endfunction%









rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_hasLabel "%~0" "DKTEST" && (
		%dk_call% dk_info "'DKTEST' is a label"
	) || ( 
		%dk_call% dk_info "'DKTEST' is NOT a label"
	)
	
	%dk_call% dk_hasLabel "%~0" "NONEXISTENT" && (
		%dk_call% dk_info "'NONEXISTENT' is a label"
	) || ( 
		%dk_call% dk_info "'NONEXISTENT' is NOT a label"
	)
%endfunction%

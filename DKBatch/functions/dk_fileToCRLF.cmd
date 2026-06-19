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


rem ####################################################################
rem # dk_fileToCRLF(file)
rem #
rem #
:dk_fileToCRLF
%setlocal%
	
	set "_file_=%~1"
	set "_crlf_=%_file_%.crlf"
	
    %dk_call% dk_isCRLF "%_file_%" && (
		%dk_call% dk_notice "%_file_% is already CRLF"
		exit /b 0
	)
	
	%dk_call% dk_validate find.exe 	%dk_call% dk_findFile find.exe
	call type "%_file_:/=\%" | %find.exe:/=\% "" /v > "%_crlf_:/=\%"
	(
		move /Y "%_crlf_:/=\%" "%_file_:/=\%" >NUL
		exit /b 0
	)

%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem forum-friendly LF variable
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	cmd /d /u /c echo.^&echo.#|>nul (pause & pause & %findstr.exe% "^" >lf.tmp)
	set /p lf= <lf.tmp
	del lf.tmp
	(set nl=^^^%lf%%lf%^%lf%%lf%)
	echo.this is a file created%nl%with LF line endings%nl%changed to CRLF line endings%nl%> 			dk_fileToCRLF_TEST.txt
	
	%dk_call% dk_fileToCRLF dk_fileToCRLF_TEST.txt
%endfunction%

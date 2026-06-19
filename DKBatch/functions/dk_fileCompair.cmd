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
rem # dk_fileCompair(fileA fileB)
rem #
rem #
:dk_fileCompair
%setlocal%

	set "fileA=%~1"
	set "fileA=%fileA:/=\%"
	
	set "fileB=%~2"
	set "fileB=%fileB:/=\%"
	
    fc %fileA% %fileB% > nul && (exit /b 0) || (exit /b 1)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_set file1 "C:/Windows/notepad.exe"
	%dk_call% dk_set file2 "C:/Windows/notepad.exe"
	%dk_call% dk_fileCompair "%file1%" "%file2%" && (echo %file1% %file2% files are the same) || (echo %file1% %file2% files are different)
	
	%dk_call% dk_set file1 "C:/Windows/notepad.exe"
	%dk_call% dk_set file2 "C:/Windows/regedit.exe"
    %dk_call% dk_fileCompair "%file1%" "%file2%" && (echo %file1% %file2% files are the same) || (echo %file1% %file2% files are different)
	%clearerror%
%endfunction%

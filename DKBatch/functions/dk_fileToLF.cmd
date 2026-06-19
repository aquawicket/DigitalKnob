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
rem # dk_fileToLF(file)
rem #
rem #
:dk_fileToLF
%setlocal%
	
	set "_file_=%~1"
	set "_file_=%_file_:\=/%"
	set "_lf_=%_file_%.lf"
	
    %dk_call% dk_isCRLF "%_file_%" || (
		%dk_call% dk_notice "%_file_% is already LF"
		exit /b 0
	)
	
	rem %dk_call% dk_validate bash_exe %dk_call% dk_depend bash_exe
	rem %bash_exe% -c "tr -d \r < %_file_:\=/% > %_lf_:\=/%"
	
	%dk_call% dk_validate tr_exe %dk_call% dk_depend unxutils
	%tr_exe% -d \r < %_file_% > %_lf_%
	(
		move /Y "%_lf_:/=\%" "%_file_:/=\%" >NUL
		exit /b 0
	)

%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

rem	>"dk_fileToLF_TEST.txt" (
rem		echo "this is a file created"
rem		echo "with CRLF line endings"
rem		echo "changed to LF line endings"
rem	)
rem    %dk_call% dk_fileToLF dk_fileToLF_TEST.txt
	
	%dk_call% dk_selectFile
	%dk_call% dk_fileToLF "%dk_selectFile%"
%endfunction%

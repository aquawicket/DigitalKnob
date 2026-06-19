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

if not defined dk_mkdir_WARNINGS (set "dk_mkdir_WARNINGS=0")
rem ####################################################################
rem # dk_mkdir(path)
rem #
rem # mkdir https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/mkdir
rem #
:dk_mkdir
rem # If Command Extensions are enabled, mkdir creates any intermediate directories in the path, if needed.
%setlocal%

	set "_path_=%~1"
	
	
	if NOT EXIST "%_path_%/*" (
		mkdir "%_path_:/=\%"
		rem %dk_call% dk_validate fsutil.exe %dk_call% dk_findFile fsutil.exe
		rem "!fsutil.exe!" file setCaseSensitiveInfo "%_path_:/=\%" enable
	) else (
		if "%dk_mkdir_WARNINGS%" equ "1" (
			%dk_call% dk_warning "%_path_% already exists"
		)
	)
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_mkdir "CreatedDirectory"
%endfunction%

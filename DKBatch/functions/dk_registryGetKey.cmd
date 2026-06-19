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


rem #################################################################################
rem # dk_registryGetKey(<reg_path>, <key>, <rtn_var:optional>
rem #
rem #
:dk_registryGetKey
%setlocal%

	set "_reg_path_=%~1"
	set "_key_=%~2"
	
	%dk_call% dk_validate reg.exe %dk_call% dk_findFile reg.exe
	
	set "_SCOPE_=%~n0"
    for /F "tokens=2* skip=2" %%a in ('%reg.exe:/=\% query "%_reg_path_:/=\%" /v "%_key_:/=\%"') do (
        if "%_SCOPE_%" equ "%~n0" endlocal
		set "dk_registryGetKey=%%b"
		if "%~2" neq "" (set "%~2=%%b")
		if "%~3" neq "" (set "%~3=%%b")
    )
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
    %dk_call% dk_registryGetKey "HKEY_LOCAL_MACHINE/SOFTWARE/Microsoft/.NETFramework" "InstallRoot" rtn_var
	%dk_call% dk_printVar dk_registryGetKey
	%dk_call% dk_printVar InstallRoot
	%dk_call% dk_printVar rtn_var
%endfunction%

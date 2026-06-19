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
rem # dk_chdir(path)
rem #
rem #		change working directory
rem #
:dk_chdir
%setlocal%

	rem ###### input ######
	set "dk_chdir=%~1"
	set "dk_chdir=%dk_chdir:\=/%"
	
	
	if NOT EXIST "%dk_chdir%" (
		%dk_call% dk_error "dk_chdir(%*): dk_chdir:'%dk_chdir%' NOT FOUND"
		%return%
	)
	if /i "%DKPWD%" equ "%dk_chdir%" (
		%dk_call% dk_notice "dk_chdir(%*): DKPWD is already set to %dk_chdir%"
		%return%
	)
	cd "%dk_chdir:/=\%"
	
	
	:return
	endlocal & (
		set "DKOLDPWD=%DKPWD%"
		set "DKPWD=%dk_chdir%"
		set "dk_chdir=%dk_chdir%"
		rem if "%~2" neq "" (set "%~2=%dk_chdir%") else (echo %dk_chdir%)
	)
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_echo
	%dk_call% dk_echo "OLD Current Directory = %DKOLDPWD%"
	%dk_call% dk_echo "Current Directory = %DKPWD%"
	
	%dk_call% dk_echo
	%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
	%dk_call% dk_chdir "%DKBRANCH_DIR%"
	%dk_call% dk_echo "OLD Current Directory = %DKOLDPWD%"
	%dk_call% dk_echo "Current Directory = %DKPWD%"
	
	%dk_call% dk_echo
	%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
	%dk_call% dk_chdir "%DKTOOLS_DIR%"
	%dk_call% dk_echo "OLD Current Directory = %DKOLDPWD%"
	%dk_call% dk_echo "Current Directory = %DKPWD%"
	
%endfunction%

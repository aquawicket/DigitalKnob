@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	if NOT DEFINED DK.cmd (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	call "%%DK.cmd:/=\%%" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ####################################################################
rem # dk_DIGITALKNOB_DIR()
rem #
rem #
:dk_DIGITALKNOB_DIR
%setlocal%
   
	rem ############ SET ############
	if "%~1" neq "" (
		set "DIGITALKNOB_DIR=%~1"
		%return%
	)
	
	rem ############ GET ############
    if NOT defined DIGITALKNOB          		(set "DIGITALKNOB=Digital Knob")
	if NOT defined DKHTTP_DIGITALKNOB         	(set "DKHTTP_DIGITALKNOB=%DIGITALKNOB%")
   
	rem ### DIGITALKNOB_DIR ###
	%dk_call% dk_validatePath DKHOME_DIR	%dk_call% DKHOME_DIR
	%dk_call% dk_validate DKHTTP_DKHOME_DIR	%dk_call% DKHOME_DIR
	set "DIGITALKNOB_DIR=%DKHOME_DIR%/%DIGITALKNOB%"
    %dk_call% dk_mkdir "%DIGITALKNOB_DIR%"
	set "DKHTTP_DIGITALKNOB_DIR=%DKHTTP_DKHOME_DIR%/%DKHTTP_DIGITALKNOB%"

	%dk_call% dk_assertPath	DIGITALKNOB_DIR
	%dk_call% dk_assertVar	DKHTTP_DIGITALKNOB_DIR
	
	endlocal & (
		set "DIGITALKNOB=%DIGITALKNOB%"
		set "DKHTTP_DIGITALKNOB=%DKHTTP_DIGITALKNOB%"
		set "DKHOME_DIR=%DKHOME_DIR%"
		set "DKHTTP_DKHOME_DIR=%DKHTTP_DKHOME_DIR%"
		set "DIGITALKNOB_DIR=%DIGITALKNOB_DIR%"
		set "DKHTTP_DIGITALKNOB_DIR=%DKHTTP_DIGITALKNOB_DIR%"
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
 
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DIGITALKNOB_DIR . . ."
	%dk_call% dk_DIGITALKNOB_DIR
	%dk_call% dk_echo "DIGITALKNOB = %DIGITALKNOB%"
	%dk_call% dk_echo "DIGITALKNOB_DIR = %DIGITALKNOB_DIR%"
	%dk_call% dk_echo "DKHTTP_DIGITALKNOB = %DKHTTP_DIGITALKNOB%"
	%dk_call% dk_echo "DKHTTP_DIGITALKNOB_DIR = %DKHTTP_DIGITALKNOB_DIR%"
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DIGITALKNOB_DIR . . ."
	%dk_call% dk_DIGITALKNOB_DIR "C:/DigitalKnob"
	%dk_call% dk_echo "DIGITALKNOB = %DIGITALKNOB%"
	%dk_call% dk_echo "DIGITALKNOB_DIR = %DIGITALKNOB_DIR%"
	%dk_call% dk_echo "DKHTTP_DIGITALKNOB = %DKHTTP_DIGITALKNOB%"
	%dk_call% dk_echo "DKHTTP_DIGITALKNOB_DIR = %DKHTTP_DIGITALKNOB_DIR%"
%endfunction%

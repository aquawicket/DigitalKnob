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
rem # dk_reset3rdparty()
rem #
rem #
:dk_reset3rdparty
%setlocal%
   
    echo Resetting 3rdParty Libraries . . .
       
    %dk_call% dk_confirm || %return%
   
	%dk_call% dk_validate DK3RDPARTY_DIR %dk_call% dk_DK3RDPARTY_DIR
    %dk_call% dk_chdir %DK3RDPARTY_DIR%
    "%git.exe%" -C %DKBRANCH_DIR% clean -f -d
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
    %dk_call% dk_reset3rdparty
%endfunction%

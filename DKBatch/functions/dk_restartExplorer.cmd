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


rem #####################################################################
rem # dk_restartExplorer()
rem #
rem #   Something strange happend when this file is run.  Windows Exploerer will reload.
rem #   And you close any open cmd processes.   But something stays residual, because any
rem #	  dk script ran after will invoke this again. I believe this ocours because after
rem #   a script header runs DK.cmd, it continues after DK.cmd's execution completes.
rem #   And since explorer has been restarted, it may be holding variables withing the
rem #   new instance. Further investigation is required.
rem #
:dk_restartExplorer
%setlocal%

	%dk_call% dk_killProcess explorer.exe
	
	%dk_call% dk_validate explorer.exe %dk_call% dk_findFile explorer.exe
	
	rem note: the /i switch will refresh the environment as well
	start /i %explorer.exe%
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_restartExplorer
%endfunction%

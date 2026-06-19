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
rem # dk_logo()
rem #
:dk_logo
%setlocal%

	echo %black%"%lblue% ______  _____ _______ ______ ______ ______        _     __ _   _   _____  ______
	echo %black%"%lblue% |     \   |   |  ____   |      |    |_____| |      |____/  | \  | |     | |_____]
	 echo %black%"%blue% |_____/ __|__ |_____| __|__    |    |     | |_____ |    \_ |  \_| |_____| |_____]
	echo %black%"%lcyan%                                                             __     __           
	echo %black%"%lcyan%                                                            |  \|_/|__) _ |_ _|_ 
	 echo %black%"%cyan%                                                            |__/| \|__)(_||_(_| )
	echo %clr%
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_logo
%endfunction%

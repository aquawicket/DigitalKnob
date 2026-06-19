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
rem # __ARGV__(<frame>)
rem #
rem :__ARGV__
remrem %setlocal%
rem 
rem	if "%_FRAME_%" equ "" (set "_FRAME_=%~1")
rem	if "%_FRAME_%" equ "" (set "_FRAME_=0")
rem 
rem	::set /a _FRAME_-=1
rem	
rem	::set "_ARGC_=%BATCH_ARGC[$_FRAME_%]%"
rem	::for (( i=((_ARGC_)); i>=1; i-- )); do
rem	rem	if NOT defined "%_ARGV_%" (set "_ARGV_=%BATCH_ARGV[%i%]%") else (set "_ARGV_=%_ARGV_%, %BATCH_ARGV[%i%]%")
rem	::done
rem	::%dk_call% dk_return "%_ARGV_%"
rem %endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	call :DKTEST_func abc 123 def 456 ghi 789
%endfunction%


:DKTEST_func
%setlocal%

	echo __ARGV__ = %__ARGV__%
	echo ARGV[1] = %ARGV[1]%
	echo ARGV[2] = %ARGV[2]%
	echo ARGV[3] = %ARGV[3]%
	echo ARGV[4] = %ARGV[4]%
	echo ARGV[5] = %ARGV[5]%
	echo ARGV[6] = %ARGV[6]%
	%dk_call% dk_printVar ARGV
	%dk_call% dk_printVar __ARGV__
%endfunction%

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
rem # dk_assertVar(var)
rem #
rem #		Check if a variable is defined and throw an Assertion if it is NOT.
rem #
rem # Throw assertion if argument is NOT a valid variable
rem #
:dk_assertVar
	if NOT defined dk_assertVar_DEBUG (set "dk_assertVar_DEBUG=1")
%setlocal%

	if NOT defined %~1 (
		rem %dk_call% dk_fatal "ASSERTION: dk_assertVar(%*) %~1 NOT defined"
		%return%
	)
	
	if "%dk_assertVar_DEBUG%" equ "1" (
		%dk_call% dk_echo "dk_assertVar %~1 = %green%'!%~1!'%clr%"
	)
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_set myVar string
	%dk_call% dk_echo "dk_assertVar(myVar)"  && %dk_call% dk_assertVar myVar

	%dk_call% dk_set myVarB 15
	%dk_call% dk_echo "dk_assertVar(myVarB)" && %dk_call% dk_assertVar myVarB

	%dk_call% dk_set myVarC "  "
	%dk_call% dk_echo "dk_assertVar(myVarC)" && %dk_call% dk_assertVar myVarC

	%dk_call% dk_set myVarD " "
	%dk_call% dk_echo "dk_assertVar(myVarD)" && %dk_call% dk_assertVar myVarD

	%dk_call% dk_set myVarE 99
	%dk_call% dk_unset myVarE
	%dk_call% dk_echo "dk_assertVar(myVarE)" && %dk_call% dk_assertVar myVarE

	%dk_call% dk_echo "dk_assertVar(noVar)"  && %dk_call% dk_assertVar noVar
%endfunction%

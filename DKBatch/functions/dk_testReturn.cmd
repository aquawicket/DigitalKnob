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
rem # dk_testReturn(input, output)
rem #
rem #
:dk_testReturn
%setlocal%

	set "input=%~1"
	set "dk_testReturn=%input:input=output%"

	endlocal & (
		set "dk_testReturn=%dk_testReturn%"
		if "%~2" neq "" (
			set "%~2=%dk_testReturn%"
		) else (
			echo %dk_testReturn%
		)
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem ### Result as global variable							[GLOBAL]
	%dk_call% dk_echo
	%dk_call% dk_testReturn "inputA"
	%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
	
	rem ### Result as parameter variable						[GLOBAL][PARAM]
	%dk_call% dk_echo
	%dk_call% dk_testReturn "inputB" resultB
	%dk_call% dk_echo "resultB = %resultB%"
	%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
	
	rem ### Result as return value							[GLOBAL][-R̶E̶T̶U̶R̶N̶ ]
	rem %dk_call% dk_echo
	rem %dk_call% resultC=dk_testReturn "inputC"				&rem NOTE: batch doesn't support return values
	rem %dk_call% dk_echo "resultC = %resultC%"
	rem %dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
	
	rem ### Result as return value and parameter variable 	[GLOBAL][PARAM][-R̶E̶T̶U̶R̶N̶ ]
	rem %dk_call% dk_echo
	rem %dk_call% resultD=dk_testReturn "inputDE"				&rem NOTE: batch doesn't support return values
	rem %dk_call% dk_echo "resultD = %resultD%"
	rem %dk_call% dk_echo "resultE = %resultE%"
	rem %dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
	
	rem ### Result from stdout								[STDOUT]
	%dk_call% dk_echo
	for /f "usebackq tokens=*" %%G in (`call dk_testReturn.cmd "inputC"`) do (set "resultC=%%G")
	%dk_call% dk_echo "resultC = %resultC%"
	rem %dk_call% dk_echo "dk_testReturn = %dk_testReturn%"	&rem NOTE: endlocal cannot be seen outside of command substituion			

%endfunction%

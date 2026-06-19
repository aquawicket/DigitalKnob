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
rem # dk_stacktrace()
rem #
:dk_stacktrace
%setlocal%
	
	echo.
	echo ############ CALLSTACK ############
	for /l %%x in (200, -1, 0) do (
		if defined __STACK__%%x (
			call echo %%x: !__STACK__%%x!
		)
	)
	echo.
exit /b 0
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	rem ##################### Create test files ##########################
	>"dk_stacktrace_TEST_A.cmd" (
		echo :dk_stacktrace_TEST_A
		echo %%dk_call%% dk_stacktrace_TEST_B
		echo %%endfunction%%
	)
	
	>"dk_stacktrace_TEST_B.cmd" (
		echo :dk_stacktrace_TEST_B
		echo %%dk_call%% dk_stacktrace_TEST_C
		echo %%endfunction%%
	)
	
	>"dk_stacktrace_TEST_C.cmd" (
		echo :dk_stacktrace_TEST_C
		echo %%dk_call%% dk_stacktrace_TEST_ERROR
		echo %%dk_call%% dk_stacktrace_TEST_D
		echo %%endfunction%%
	)
	
	>"dk_stacktrace_TEST_D.cmd" (
		echo :dk_stacktrace_TEST_D
		echo %%endfunction%%
	)
	
	>"dk_stacktrace_TEST_ERROR.cmd" (
		echo :dk_stacktrace_TEST_ERROR
		echo SYNTAX ERROR
		echo %%endfunction%%
	)
	rem ######################################################################
	
	%dk_call% dk_stacktrace_TEST_A

	rem %dk_call% dk_stacktrace
%endfunction%


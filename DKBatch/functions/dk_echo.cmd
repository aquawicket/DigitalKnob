@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::set "dk_echo_NONEWLINE=1"
::################################################################################
::# dk_echo(message)
::#
::#		Print a message to the console
::#
::#		@msg - The message to print
::#
:dk_echo
::setlocal disableDelayedExpansion
	::%dk_call% dk_debugFunc 0 1

    if "%~1" equ "" (echo( & exit /b 0)  
	
	set message=%*
	:DeEscape
	echo %message% | findstr /c:"^^" >nul && (
		set message=%message:^^=^%
		goto :DeEscape
	) || cmd /c "exit /b 0"
	
::	set "message=%message:""="%" && echo(%message%
::	for /f %%G in (%message%) do (echo(%%~G)
::	for /f "tokens=*" %%G in (%message%) do (echo(%%~G)
::	for /f "delims=" %%G in (%message%) do (echo(%%~G)
	for /f "tokens=1* delims==" %%G in ('set message') do (echo(%%~H)
::	for /f "usebackq delims=" %%G in (`echo(%message%`) do (echo(%%~G)

%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
    %dk_call% dk_debugFunc 0

	echo This is a normal echo commmand
	%dk_call% dk_echo
	%dk_call% dk_echo ""
	%dk_call% dk_echo "This is a dk_echo line"
	%dk_call% dk_echo This is a dk_echo line without quotes
	%dk_call% dk_echo "This is a dk_echo line \nwith a new line"
	%dk_call% dk_echo "%red%This is %white%dk_echo %blue%with color %clr%"
	
	::############### Special Characters ###############
								 ::ALL: "   !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~"
							 ::INVALID: "   !"  %                           "
							   ::VALID: "     #$ &'()*+,-./:;<=>?@[\]^_`{|}~"
							   
			   ::setlocal disableDelayedExpansion
			   echo(
::								   echo("   ! #$ &'()*+,-./:;<=>?@[\]^_`{|}~"
::			  for /f "tokens=*" %%G in ("   ! #$ &'()*+,-./:;<=>?@[\]^_`{|}~") do (echo(%%~G)
			   for /f "delims=" %%G in ("     #$ &'()*+,-./:;<=>?@[\]^_`{|}~") do (echo(%%~G)
			   echo(
			   
::			   <nul (set/p demo="             #$ &'()*+,-./:;<=>?@[\]^_`{|}~")
::			   echo(
			   ::endlocal
				setlocal disableDelayedExpansion
			                    set "var=   !""#$ &'()*+,-./:;<=>?@[\]^_`{|}~"
				for /f "tokens=1* delims==" %%a in ('set var') do echo %%b
				endlocal

					  echo(###### TEST_A - call w/ Valid Characters ######
					  call dk_echo "     #$ &'()*+,-./:;<=>?@[\]^_`{|}~"
					  echo(

					  echo(###### TEST_B - call w/ " ######
					  call dk_echo "   ""#$ &'()*+,-./:;<=>?@[\]^_`{|}~"
					  echo(

					  echo(###### TEST_C - call /w %% ######
					  call dk_echo "     #$%%%%%%%%&'()*+,-./:;<=>?@[\]^_`{|}~"
					  echo(
%endfunction%						   
						   setlocal disableDelayedExpansion
						   echo(###### TEST_D - call w/ ! (disableDelayedExpansion) ######
					       call dk_echo "   !"
						   echo(
						   endlocal
						   
						   setlocal disableDelayedExpansion
						   echo(###### TEST_D - call w/ ! (disableDelayedExpansion) ######
					       call dk_echo "   ! #$ &'()*+,-./:;<=>?@[\]^_`{|}~"
						   echo(
						   endlocal

						   setlocal disableDelayedExpansion
						   echo(###### TEST_E - call w/ ! and " (disableDelayedExpansion) ######
					       call dk_echo "  !""#$ &'()*+,-./:;<=>?@[\]^_`{|}~"
						   echo(
						   endlocal 

						   setlocal disableDelayedExpansion
						   echo ###### TEST_F - call w/ ! and " and % (disableDelayedExpansion) ######
					       call dk_echo "  !""#$%%%%&'()*+,-./:;<=>?@[\]^_`{|}~"
						   echo(
						   endlocal
%endfunction%

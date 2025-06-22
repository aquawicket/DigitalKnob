@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_echo(message)
::#
::#     Print a message to the console
::#
::#     @msg    - The message to print
::#
:dk_echo
::setlocal disableDelayedExpansion
    ::%dk_call% dk_debugFunc 0 1

    if "%~1" equ "" (echo: & exit /b 0)  
	
	set message=%*
	
	:DeEscape
	echo %message% | findstr /c:"^^" >nul && (
		set message=%message:^^=^%
		goto :DeEscape
	)
	
	::set "message=%message:""="%"
	for /f "delims=" %%G in (%message%) do (echo:%%~G)
::	for /f "usebackq delims=" %%G in (`echo:%message%`) do (echo %%~G)
%endfunction%


::set "dk_echo=echo"



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
    %dk_call% dk_debugFunc 0


    echo This is a normal echo commmand
    %dk_call% dk_echo
    %dk_call% dk_echo ""
    %dk_call% dk_echo "This is a dk_echo line"
    %dk_call% dk_echo "%red%This is %white%dk_echo %blue%with color %clr%"
	
	echo This is a normal echo commmand
    %dk_call% dk_echo
    %dk_call% dk_echo ""
    %dk_call% dk_echo "This is a dk_echo line"
    %dk_call% dk_echo "%red%This is %white%dk_echo %blue%with color %clr%"
	
	::############### Special Characters ###############
                                 ::ALL: "   !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~"
		                     ::INVALID: "   !"  %                           "
		                       ::VALID: "     #$ &'()*+,-./:;<=>?@[\]^_`{|}~"
							   
::			                        echo:"    #$ &'()*+,-./:;<=>?@[\]^_`{|}~"
::             for /f "tokens=*" %%G in ("     #$ &'()*+,-./:;<=>?@[\]^_`{|}~") do (echo:%%~G)
               for /f "delims=" %%G in ("     #$ &'()*+,-./:;<=>?@[\]^_`{|}~") do (echo:%%~G)

					  ::###### dk_call w/ Valid Characters ######
					  %dk_call% dk_echo "     #$ &'()*+,-./:;<=>?@[\]^_`{|}~"
						   
					  ::###### dk_call w/ " ######
					  %dk_call% dk_echo "   ""#$ &'()*+,-./:;<=>?@[\]^_`{|}~"
						   
					  ::###### dk_call /w % ######
					  %dk_call% dk_echo "     #$%%%%%%%%&'()*+,-./:;<=>?@[\]^_`{|}~"
						   
						   ::###### call w/ ! (disableDelayedExpansion) ######
						   setlocal disableDelayedExpansion
					       call dk_echo "   ! #$ &'()*+,-./:;<=>?@[\]^_`{|}~"
						   endlocal
						   
						   ::###### call w/ ! and " (disableDelayedExpansion) ######
						   setlocal disableDelayedExpansion
					       call dk_echo "  !""#$ &'()*+,-./:;<=>?@[\]^_`{|}~"
						   endlocal 
						   
						   ::###### call w/ ! and " and % (disableDelayedExpansion) ######
						   setlocal disableDelayedExpansion
					       call dk_echo "  !""#$%%%%&'()*+,-./:;<=>?@[\]^_`{|}~"
						   endlocal
%endfunction%

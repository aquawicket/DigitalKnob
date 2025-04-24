<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::################################################################################
::# dk_unset(name)
::#
::#
:dk_unset
<<<<<<< HEAD
    call dk_debugFunc 1
:: setlocal
   
    set "%~1="
=======
setlocal
	%dk_call% dk_debugFunc 1

	endlocal & (
		set "%~1="
	)
>>>>>>> Development
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_set myVar "initial value assigned with dk_unset"
    echo myVar = %myVar%
    %dk_call% dk_unset myVar
    echo myVar = %myVar%
=======
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_set myVar "initial value assigned with dk_unset"
	echo myVar = %myVar%
	%dk_call% dk_unset myVar
	echo myVar = %myVar%
>>>>>>> Development
%endfunction%

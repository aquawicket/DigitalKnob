<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################
>>>>>>> Development


set "_DE_=%if_DE% (echo delayed expansion ON) else (echo delayed expansion OFF)" 

::####################################################################
<<<<<<< HEAD
::# dk_isDelayedExpansion(rtn_var)
::#
::#
:dk_isDelayedExpansion
    call dk_debugFunc 1
 setlocal
 
    if "!DE!" == "" (
      set "%1=ON"
    )  else (
      set "%1=OFF"
    )
=======
::# dk_isDelayedExpansion(<ret>:OPTIONAL)
::#
::#
:dk_isDelayedExpansion
setlocal
	%dk_call% dk_debugFunc 0 1
	
    if "!DE!" equ "" (
      set "dk_isDelayedExpansion=0"
    )  else (
      set "dk_isDelayedExpansion=1"
    )
	
	endlocal & (
		set "dk_isDelayedExpansion=%dk_isDelayedExpansion%"
		if "%~1" neq "" (set "%~1=%dk_isDelayedExpansion%")
		exit /b %dk_isDelayedExpansion%
	)
>>>>>>> Development
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal

    
    %dk_call% dk_isDelayedExpansion deylayedExpansion
    echo deylayedExpansion = %deylayedExpansion%
=======
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_isDelayedExpansion && echo Delayed expansion is ON || echo Delayed expansion is OFF

>>>>>>> Development
%endfunction%
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
::# dk_getDate(day month year)
::#
<<<<<<< HEAD
::#    REFERENCE: https://ss64.com/nt/syntax-gettime.html
::#
:dk_getDate
    call dk_debugFunc 3
 setlocal
 
    set t=2&if "%date%z" LSS "A" set t=1
    for /f "skip=1 tokens=2-4 delims=(-)" %%a in ('echo/^|date') do (
        for /f "tokens=%t%-4 delims=.-/ " %%d in ('date/t') do (
            set %%a=%%d
            set %%b=%%e
            set %%c=%%f
        )
    )
    endlocal & set "%1=%dd%" & set "%2=%mm%" & set "%3=%yy%"
	
::debug
::	%dk_call% dk_printVar %1
::	%dk_call% dk_printVar %2
::	%dk_call% dk_printVar %3
=======
::#	REFERENCE: https://ss64.com/nt/syntax-gettime.html
::#
:dk_getDate
setlocal
	%dk_call% dk_debugFunc 3
	set t=2&if "%date%z" LSS "A" set t=1
	for /f "skip=1 tokens=2-4 delims=(-)" %%a in ('echo/^|date') do (
		for /f "tokens=%t%-4 delims=.-/ " %%d in ('date/t') do (
			set %%a=%%d
			set %%b=%%e
			set %%c=%%f
		)
	)
	endlocal & (
		set "%~1=%dd%"
		set "%~2=%mm%"
		set "%~3=%yy%"
	)
>>>>>>> Development
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_echo "date = %date%"
    %dk_call% dk_getDate day month year
    %dk_call% dk_echo "date = %month%/%day%/%year%"
=======
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_echo "date = %date%"
	%dk_call% dk_getDate day month year
	%dk_call% dk_echo "date = %month%/%day%/%year%"
>>>>>>> Development
%endfunction%   
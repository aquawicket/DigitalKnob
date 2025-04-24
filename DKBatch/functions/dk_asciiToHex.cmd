<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_asciiToHex(ascii, rtn_var)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_asciiToHex
    call dk_debugFunc 2
 setlocal
 
    :: Store the string in chr.tmp file
    set /P "=%~1" < NUL > chr.tmp

    :: Create zero.tmp file with the same number of Ascii zero characters
    for %%a in (chr.tmp) do fsutil file createnew zero.tmp %%~Za > NUL

    :: Compare both files with FC /B and get the differences
    set "hex="
    for /F "skip=1 tokens=2" %%a in ('fc /B chr.tmp zero.tmp') do set "hex=%%a"
    del chr.tmp zero.tmp
    set "hex=0x%hex:~-2%"
    
    endlocal & set "%2=%hex%"

:: debug
	%dk_call% dk_printVar %2
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_asciiToHex(ascii, <rtn_var>:optional)
::#
::#	reference: https://www.ascii-code.com
::#
:dk_asciiToHex
setlocal
	%dk_call% dk_debugFunc 1 2

	:: Store the string in chr.tmp file
	set /P "=%~1" < NUL > chr.tmp

	:: Create zero.tmp file with the same number of Ascii zero characters
	for %%a in (chr.tmp) do fsutil file createnew zero.tmp %%~Za > NUL

	:: Compare both files with FC /B and get the differences
	set "dk_asciiToHex="
	for /F "skip=1 tokens=2" %%a in ('fc /B chr.tmp zero.tmp') do set "dk_asciiToHex=%%a"
	del chr.tmp zero.tmp
	set "dk_asciiToHex=0x%dk_asciiToHex:~-2%"

	endlocal & (
		set "dk_asciiToHex=%dk_asciiToHex%"
		if "%~2" neq "" (set "%~2=%dk_asciiToHex%")
	)
	
::DEBUG	
::	echo dk_asciiToHex %* = %dk_asciiToHex%
>>>>>>> Development
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_set myAscii x
    %dk_call% dk_asciiToHex myAscii myHex
    %dk_call% dk_info "myHex = %myHex%"
=======
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_set myAscii a
	%dk_call% dk_asciiToHex %myAscii%
	%dk_call% dk_echo "'%myAscii%': dk_asciiToHex = %dk_asciiToHex%"

	%dk_call% dk_set myAscii b
	%dk_call% dk_asciiToHex %myAscii%
	%dk_call% dk_echo "'%myAscii%': dk_asciiToHex = %dk_asciiToHex%"

	%dk_call% dk_set myAscii c
	%dk_call% dk_asciiToHex %myAscii%
	%dk_call% dk_echo "'%myAscii%': dk_asciiToHex = %dk_asciiToHex%"
>>>>>>> Development
%endfunction%

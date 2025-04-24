<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_getDirectories(path rtn_var)
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_getDirectories(path)
>>>>>>> Development
::#
::#   reference: https://stackoverflow.com/a/138581
::#
:dk_getDirectories
<<<<<<< HEAD
    call dk_debugFunc 2
 setlocal
	::%dk_call% dk_debug "dk_getDirectories[%~1, %~2]"
	%dk_call% dk_assertPath "%~1"
 
    %dk_call% dk_replaceAll "%~1" "/" "\" _path_
    set /A i=0

    for /d %%a in ("%_path_%\*") do (
        if "!DE!" equ "" set "%~2[!i!]=%%a"
        if "!DE!" neq "" call set "%~2[%%i%%]=%%a"
        set /A i+=1
    ) 

    :: Return the array to the calling scope
    set "currentScope=1"
    for /F "delims=" %%a in ('set %~2[') do (
       if defined currentScope endlocal
       set "%%a"
    )

%DEBUG%
	%dk_call% dk_printVar %~2
=======
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 1

	set "_path_=%~1"
	%dk_call% dk_assertPath "%_path_%"

	set /a "n=0"
	for /d %%a in ("%_path_:/=\%\*") do (
		set "temp=%%a"
		set "dk_getDirectories[!n!]=!temp:\=/!"
		set /a "n+=1"
	) 

	::### Return the array to the calling scope ###
	set "currentScope=1"
	for /F "delims=" %%b in ('set dk_getDirectories[') do (
		if defined currentScope endlocal
		set "%%b"
	)
>>>>>>> Development
%endfunction%






<<<<<<< HEAD
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_set myPath "C:\Windows"
    %dk_call% dk_getDirectories "%myPath%" directories
    %dk_call% dk_printVar directories
%endfunction%
    
=======

::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_getDirectories "C:"
	%dk_call% dk_printVar dk_getDirectories
	%dk_call% Array/dk_length dk_getDirectories
	%dk_call% dk_echo "directories %dk_length%"

	%dk_call% dk_set myPath "C:/Windows"
	%dk_call% dk_getDirectories "%myPath%"
	%dk_call% dk_printVar dk_getDirectories
	%dk_call% Array/dk_length dk_getDirectories
	%dk_call% dk_echo "directories %dk_length%"
%endfunction%
>>>>>>> Development

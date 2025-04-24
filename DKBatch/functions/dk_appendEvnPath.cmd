<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_appendEvnPath(array, index, element)
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_appendEvnPath(path)
>>>>>>> Development
::#
::#   Func: Appends a path to the %PATH% environment variable
::#   path: A string containing the new path
::#
<<<<<<< HEAD
::#    Example:  call dk_appendEvnPath C:\Windows\System32 result
::#              echo dk_appendEvnPath returned: %result%
::#
:dk_appendEvnPath
    call dk_debugFunc 1
 setlocal
 
    set "_path_=%~1"
    %dk_call% dk_stringContains "%PATH%\" "%_path_%" result

    if "%result%" equ "true" dk_info "path already in list" && endlocal & %return%

    setx PATH "%PATH%";"%_path_%" >nul
    set "PATH=%PATH%;%_path_%"
    if "%ERRORLEVEL%" neq "0" dk_error "ERROR: %ERRORLEVEL%"
	
::debug
::	%dk_call% dk_debug "%PATH%"
=======
::#	Example:  %dk_call% dk_appendEvnPath C:\Windows\System32 result
::#			  echo dk_appendEvnPath returned: %result%
::#
:dk_appendEvnPath
setlocal
	%dk_call% dk_debugFunc 1

	set "_path_=%~1"

	%dk_call% dk_contains "%PATH%" "%_path_:/=\%;" && (
		%dk_call% dk_info "environment PATH already contains _path_:%_path_%"
		%return%
	)

	endlocal & (
		set "PATH=%PATH%;%_path_:/=\%"
	)
>>>>>>> Development
%endfunction%





<<<<<<< HEAD
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_validate DKBATCH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
    %dk_call% dk_appendEvnPath "%DKBATCH_FUNCTIONS_DIR%"
=======





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	::%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	::%dk_call% dk_appendEvnPath "%DKBATCH_FUNCTIONS_DIR%"

	%dk_call% dk_appendEvnPath "C:/Users/Administrator/digitalknob/Development/DKCMake"
	echo %PATH%
>>>>>>> Development
%endfunction%

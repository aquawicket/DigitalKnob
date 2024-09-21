@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_appendEvnPath(array, index, element)
::#
::#   Func: Appends a path to the %PATH% environment variable
::#   path: A string containing the new path
::#
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
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_validate DKBATCH_FUNCTIONS_DIR "%dk_call% dk_validateBranch"
    %dk_call% dk_appendEvnPath "%DKBATCH_FUNCTIONS_DIR%"
%endfunction%

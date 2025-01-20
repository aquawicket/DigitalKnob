@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_appendEvnPath(path)
::#
::#   Func: Appends a path to the %PATH% environment variable
::#   path: A string containing the new path
::#
::#    Example:  %dk_call% dk_appendEvnPath C:\Windows\System32 result
::#              echo dk_appendEvnPath returned: %result%
::#
:dk_appendEvnPath
::setlocal
	::%dk_call% dk_debugFunc 1

 
    set "_path_=%~1"
	set "_path_=%_path_:/=\%"
    %dk_call% dk_stringContains "%PATH%;" "%_path_%;" && %dk_call% dk_info "path already in list" && %return%

    set "PATH=%PATH%;%_path_%"
	setx PATH %PATH%
    if "%ERRORLEVEL%" neq "0" dk_error "ERROR: %ERRORLEVEL%"
%endfunction%










::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

 
    ::%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
    ::%dk_call% dk_appendEvnPath "%DKBATCH_FUNCTIONS_DIR%"
	
	%dk_call% dk_appendEvnPath "C:/Users/Administrator/digitalknob/DKCMake"
	echo %PATH%
%endfunction%

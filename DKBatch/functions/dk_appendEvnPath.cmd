@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

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
setlocal
	%dk_call% dk_debugFunc 1

    set "_path_=%~1"

    %dk_call% dk_stringContains "%PATH%" "%_path_:/=\%;" && (
		%dk_call% dk_info "environment PATH already contains _path_:%_path_%"
		%return%
	)

	endlocal & (
		set "PATH=%PATH%;%_path_:/=\%"
	)
%endfunction%










::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    ::%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
    ::%dk_call% dk_appendEvnPath "%DKBATCH_FUNCTIONS_DIR%"
	
	%dk_call% dk_appendEvnPath "C:/Users/Administrator/digitalknob/Development/DKCMake"
	echo %PATH%
%endfunction%

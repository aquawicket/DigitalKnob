@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_isDirectory(path rtn_var)
::#
::#
:dk_isDirectory
 setlocal
	call dk_debugFunc 1
	
	if exist %~1\* (
		if defined "%~2" (endlocal & set "%2=true")
        (call ) %NO_STD%
		goto:eof
	)
	
    if defined "%~2" (endlocal & set "%2=false")
	(call) %NO_STD%
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_isDirectory "C:\Windows" && %dk_call% dk_info "'C:\Windows' is a directory" || %dk_call% dk_info "'C:\Windows' is NOT a directory"
	%dk_call% dk_isDirectory "C:\NotADir" && %dk_call% dk_info "'C:\NotADir' is a directory" || %dk_call% dk_info "'C:\NotADir' is NOT a directory"
%endfunction%

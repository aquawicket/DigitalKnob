@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::############################################################################
::# dk_compair(fileA fileB)
::#
::#
:dk_compair
setlocal
	%dk_call% dk_debugFunc 0

	set "fileA=%~1"
	set "fileB=%~2"
    fc %fileA% %fileB% > nul && (exit /b 0) || (exit /b 1)

%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_compair "C:\Windows\notepad.exe" "C:\Windows\splwow64.exe" && (echo files are the same) || (echo files are different)
%endfunction%

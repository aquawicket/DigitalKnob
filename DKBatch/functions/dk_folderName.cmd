@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_folderName(<input> rtn_var)
::#
::#
:dk_folderName
setlocal
	%dk_call% dk_debugFunc 2

	for %%a in ("%1") do for %%b in ("%%~dpa\.") do set "dk_folderName=%%~nxb"
	endlocal & (
		set "dk_folderName=%dk_folderName%"
	)
	%dk_call% dk_printVar dk_folderName
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_folderName "C:/Windows/System32"
%endfunction%

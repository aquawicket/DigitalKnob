@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_CSCRIPT_EXE()
::#
::#
:dk_CSCRIPT_EXE
setlocal
	%dk_call% dk_debugFunc 0

	if exist "%CSCRIPT_EXE%" (%return%)

	if not exist "%CSCRIPT_EXE%" (%dk_call% dk_findProgram CSCRIPT_EXE "cscript.exe" "%WINDIR:\=/%/System32")

	for %%Z in ("%CSCRIPT_EXE%") do set "CSCRIPT_EXE=%%~fZ"

	endlocal & (
		set "CSCRIPT_EXE=%CSCRIPT_EXE:\=/%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_CSCRIPT_EXE
	%dk_call% dk_printVar CSCRIPT_EXE
%endfunction%

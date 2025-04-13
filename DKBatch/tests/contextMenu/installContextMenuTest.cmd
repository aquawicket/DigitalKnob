@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../functions/")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_installGitContextMenu()
::#
:installContextMenuTest
	%dk_call% dk_debugFunc 0
	
	set "TITLE=TEST"
	set "ICON=cmd.exe"
	set "COMMAND=echo todo"
	
	%dk_call% dk_installContextMenu "%TITLE%" "%ICON%" "%COMMAND%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	setlocal
	%dk_call% dk_debugFunc 0
	
    call installContextMenuTest
%endfunction%

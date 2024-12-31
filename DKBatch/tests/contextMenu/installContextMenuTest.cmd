@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

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
	%dk_call% dk_debugFunc 0
	
    call installContextMenuTest
%endfunction%

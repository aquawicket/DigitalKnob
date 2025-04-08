@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../../../../DKBatch/functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate NOTEPADPP_EXE "%dk_call% %DKIMPORTS_DIR%\notepadpp\DKINSTALL.cmd"
	%dk_call% dk_installContextMenu "Edit with Notepad++" "%NOTEPADPP_EXE%" "\"%NOTEPADPP_EXE%\" \"%%%%1\""
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	setlocal
	%dk_call% dk_debugFunc 0
	
    call :DKINSTALL
%endfunction%

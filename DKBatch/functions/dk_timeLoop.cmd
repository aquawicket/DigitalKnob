@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_timeLoop()
::#
:dk_timeLoop
	title %time%
	goto :dk_timeLoop
%endfunction%
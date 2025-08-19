@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_callFileLabel(batch_file label)
::#
::#
:dk_callFileLabel
%setlocal%
	%dk_call% dk_debugFunc 2

	set "_file_=%~1"
	set "_label_=%~2"
	
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	echo @echo off > 		"%DKCACHE_DIR%/dk_callFileLabel_TEMP.cmd"
	echo call %_label_% >> 	"%DKCACHE_DIR%/dk_callFileLabel_TEMP.cmd"
	echo %_label_% >> 		"%DKCACHE_DIR%/dk_callFileLabel_TEMP.cmd"
	echo "%_file_%" >> 		"%DKCACHE_DIR%/dk_callFileLabel_TEMP.cmd"

	%dk_call% "%DKCACHE_DIR%/dk_callFileLabel_TEMP.cmd"
	%dk_call% dk_delete "%DKCACHE_DIR%/dk_callFileLabel_TEMP.cmd"

%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_callFileLabel "C:\Users\Administrator\DigitalKnob\Development\DKBatch\functions\dk_debug.cmd" ":DKTEST"
%endfunction%


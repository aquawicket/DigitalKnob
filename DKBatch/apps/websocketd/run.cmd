@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# RUN
::#
:RUN
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate WEBSOCKETD_EXE "%dk_call% dk_depend websocketd"
	%dk_call% dk_validate cmd_exe "%dk_call% dk_depend cmd"
	
	::%WEBSOCKETD_EXE% --devconsole --port=8080 count.cmd
	::%WEBSOCKETD_EXE% --devconsole --port=8080 C:\Users\Administrator\DigitalKnob\Development\DKBatch\functions\DKBuilder\DKBuilder.cmd
	start C:/Users/Administrator/DigitalKnob/Development/DKBatch/apps/websocketd/console.html
	::"%WEBSOCKETD_EXE%" --port=8080 --staticdir=%DIGITALKNOB_DIR:/=\% stdparser.cmd
	::"%WEBSOCKETD_EXE%" --port=8080 --staticdir=. stdparser.cmd
	"%WEBSOCKETD_EXE%" --port=8080 cmd /V:ON
%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% RUN
%endfunction%
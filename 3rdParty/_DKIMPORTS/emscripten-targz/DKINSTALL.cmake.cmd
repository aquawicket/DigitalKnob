@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL
::#
:DKINSTALL
%setlocal%
	%dk_call% dk_debugFunc 0 

	::%dk_call% dk_cmakeEval "dk_load('%~dpn0')"
	
	%dk_call% dk_validate cmake_exe "%dk_call% dk_depend cmake"
	%dk_call% dk_validate DKCMAKE_FUNCTIONS_DIR_ "%dk_call% dk_DKBRANCH_DIR"
	set "DKSCRIPT_PATH=%~dpn0"
	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"

	::###### run script ######
	set cmnd="%ComSpec%" /V:ON /K call "%cmake_exe%" -P "%DKSCRIPT_PATH%"
	echo %cmnd%
	%cmnd% & echo success || echo failed

%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0 

	call :DKINSTALL
%endfunction%

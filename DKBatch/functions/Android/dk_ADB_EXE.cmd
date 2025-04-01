@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_ADB_EXE(cmake_commands, return_variables, -DVARS)
::#
:dk_ADB_EXE
::setlocal
	%dk_call% dk_debugFunc 1 4

	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
    %dk_call% dk_cmakeEval "dk_load(%DKIMPORTS_DIR%/android-platform-tools/DKMAKE.cmake)" "ADB_EXE"
	%dk_call% dk_assertVar ADB_EXE
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_ADB_EXE
	echo ADB_EXE = %ADB_EXE%
%endfunction%

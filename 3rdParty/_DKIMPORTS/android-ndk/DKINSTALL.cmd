@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../../../DKBatch/functions/")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validatePath DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
    %dk_call% dk_cmakeEval "dk_load(%DKIMPORTS_DIR%/android-ndk/DKINSTALL.cmake)" "ANDROID_GENERATOR;ANDROID_API;ANDROID_NDK;ANDROID_TOOLCHAIN_FILE"
    %dk_call% dk_assertVar ANDROID_GENERATOR
    %dk_call% dk_assertVar ANDROID_API
    %dk_call% dk_assertVar ANDROID_NDK
    %dk_call% dk_assertVar ANDROID_TOOLCHAIN_FILE
	endlocal & (
		set "ANDROID_GENERATOR=%ANDROID_GENERATOR%"
		set "ANDROID_API=%ANDROID_API%"
		set "ANDROID_NDK=%ANDROID_NDK%"
		set "ANDROID_TOOLCHAIN_FILE=%ANDROID_TOOLCHAIN_FILE%"
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
 
	%dk_call% DKINSTALL
%endfunction%
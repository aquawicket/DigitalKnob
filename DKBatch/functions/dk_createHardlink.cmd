@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_createHardlink(src_path, hardlink_path)
::#
::#
:dk_createHardlink
%setlocal%
	%dk_call% dk_debugFunc 2
	
	set "src_path=%~1"
	set "hardlink_path=%~2"
	
	%dk_call% dk_assertPath %src_path%
	
	if EXIST "%hardlink_path%" (
		%dk_call% dk_notice "hardlink_path:'%hardlink_path%' already exists"
		%return%
	)
	
	%dk_call% dk_assertPath "%src_path%"
	%dk_call% dk_isDirectory "%src_path%" && (set "/D=/D")
	
	::FIXME:  mklink is a internal command only in Windows Vista and up
	mklink %/D% /H "%hardlink_path:/=\%" "%src_path:/=\%"
	
	::### cmake ###
::	%dk_call% dk_validate DKIMPORTS_DIR		"%dk_call% dk_DKIMPORTS_DIR"
::	%dk_call% dk_validate cmake_exe			"%dk_call% dk_depend cmake"
::	"%cmake_exe%" -E create_symlink 		"%src_path%" "%hardlink_path%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::### Create a file symlink ###
	%dk_call% dk_createHardlink "%USERPROFILE:\=/%/test.txt" "%USERPROFILE:\=/%/Desktop/test.txt"
	
	::### Create a directory symlink ###
    %dk_call% dk_createHardlink "%USERPROFILE:\=/%/test" "%USERPROFILE:\=/%/Desktop/test"
	
	::### Test Non-Existent Error ###
    ::%dk_call% dk_createHardlink "%USERPROFILE:\=/%/Desktop/Non-Existent" "C:/Non-Existent"
%endfunction%

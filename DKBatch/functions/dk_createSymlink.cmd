@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_createSymlink(src_path, symlink_path)
::#
::#		FIXME:  mklink is a internal command only in Windows Vista and up
::#
:dk_createSymlink
%setlocal%
	%dk_call% dk_debugFunc 2
	
	set "src_path=%~1"
	set "symlink_path=%~2"
	
	%dk_call% dk_assertPath %src_path%
	
	if exist "%symlink_path%" (
		%dk_call% dk_notice "symlink_path:'%symlink_path%' already exists"
		%return%
	)
	
	%dk_call% dk_assertPath "%src_path%"
	%dk_call% dk_isDirectory "%src_path%" && (set "/D=/D")
	
	::FIXME:  mklink is a internal command only in Windows Vista and up
	mklink %/D% "%symlink_path:/=\%" "%src_path:/=\%"	
%endfunction%










::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::### Create a directory symlink ###
    %dk_call% dk_createSymlink "%USERPROFILE:\=/%/digitalknob" "%USERPROFILE:\=/%/Desktop/digitalknob"
	
	::### Create a file symlink ###
	%dk_call% dk_createSymlink "%USERPROFILE:\=/%/digitalknob/Development/DKBatch/apps/DKBuilder/DKBuilder.cmd" "%USERPROFILE:\=/%/Desktop/DKBuilder.cmd" &rem OVERWRITE
	
	::### Test Non-Existent Error ###
    ::%dk_call% dk_createSymlink "C:/Non-Existent" "%USERPROFILE:\=/%/Desktop/Non-Existent"
%endfunction%

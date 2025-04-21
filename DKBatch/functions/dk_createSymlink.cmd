@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_createSymlink(src_path, symlink_path)
::#
::#
:dk_createSymlink
setlocal
	%dk_call% dk_debugFunc 2
	
	if not exist 
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
setlocal
	%dk_call% dk_debugFunc 0

	::### Create a directory symlink ###
    %dk_call% dk_createSymlink "C:/Users/Administrator/digitalknob" "C:/Users/Administrator/Desktop/digitalknob"
	
	::### Create a file symlink ###
	%dk_call% dk_createSymlink "C:/Users/Administrator/digitalknob/Development/DKBatch/apps/DKBuilder/DKBuilder.cmd" "C:/Users/Administrator/Desktop/DKBuilder.cmd" &rem OVERWRITE
	
	::### Test Non-Existent Error ###
    ::%dk_call% dk_createSymlink "C:/Non-Existent" "C:/Users/Administrator/Desktop/Non-Existent" 
%endfunction%

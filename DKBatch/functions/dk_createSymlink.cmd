@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_createSymlink(symlink_path, src_path)
::#
::#
:dk_createSymlink
setlocal
	%dk_call% dk_debugFunc 2
	
	set "symlink_path=%~1"
	set "src_path=%~2"
	
	%dk_call% dk_assertPath %src_path%
	
	if exist "%symlink_path%" (
		%dk_call% dk_notice "symlink_path:'%symlink_path%' already exists"
		%return%
	)
	
	%dk_call% dk_assertPath "%src_path%"
	%dk_call% dk_isDirectory "%src_path%" && (set "/D=/D")
	
	::FIXME:  mklink is a internal command only in Windows Vista and up
	mklink %/D% "%symlink_path:/=\%" "%src_path:/=\%"
	
	::### CMAKE ###
::	%dk_call% dk_validate DKIMPORTS_DIR		"%dk_call% dk_DKIMPORTS_DIR"
::	%dk_call% dk_validate CMAKE_EXE			"%dk_call% %DKIMPORTS_DIR%/cmake/DKINSTALL.cmd"
::	"%CMAKE_EXE%" -E create_symlink 		"%src_path%" "%symlink_path%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	::### Create a directory symlink ###
    %dk_call% dk_createSymlink "C:/Users/Administrator/Desktop/digitalknob" "C:/Users/Administrator/digitalknob"
	
	::### Create a file symlink ###
	%dk_call% dk_createSymlink "C:/Users/Administrator/Desktop/DKBuilder.cmd" "C:/Users/Administrator/digitalknob/Development/DKBatch/apps/DKBuilder/DKBuilder.cmd" &rem OVERWRITE
	
	::### Test Non-Existent Error ###
    ::%dk_call% dk_createSymlink "C:/Users/Administrator/Desktop/Non-Existent" "C:/Non-Existent"
%endfunction%

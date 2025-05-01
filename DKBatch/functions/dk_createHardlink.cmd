@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
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
	
	if exist "%hardlink_path%" (
		%dk_call% dk_notice "hardlink_path:'%hardlink_path%' already exists"
		%return%
	)
	
	%dk_call% dk_assertPath "%src_path%"
	%dk_call% dk_isDirectory "%src_path%" && (set "/D=/D")
	
	::FIXME:  mklink is a internal command only in Windows Vista and up
	mklink %/D% /H "%hardlink_path:/=\%" "%src_path:/=\%"
	
	::### CMAKE ###
::	%dk_call% dk_validate DKIMPORTS_DIR		"%dk_call% dk_DKIMPORTS_DIR"
::	%dk_call% dk_validate CMAKE_EXE			"%dk_call% %DKIMPORTS_DIR%/cmake/DKINSTALL.cmd"
::	"%CMAKE_EXE%" -E create_symlink 		"%src_path%" "%hardlink_path%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::### Create a file symlink ###
	%dk_call% dk_createHardlink "C:/Users/Administrator/test.txt" "C:/Users/Administrator/Desktop/test.txt"
	
	::### Create a directory symlink ###
    %dk_call% dk_createHardlink "C:/Users/Administrator/test" "C:/Users/Administrator/Desktop/test" 
	
	::### Test Non-Existent Error ###
    ::%dk_call% dk_createHardlink "C:/Users/Administrator/Desktop/Non-Existent" "C:/Non-Existent"
%endfunction%

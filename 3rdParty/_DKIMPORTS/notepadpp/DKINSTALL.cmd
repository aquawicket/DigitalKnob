@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%../../../DKBatch/functions/")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
::setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
	if defined win_arm64_host	(set "NOTEPADPP_IMPORT=https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.arm64.zip")
    if defined win_x86_host		(set "NOTEPADPP_IMPORT=https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.zip")
    if defined win_x86_64_host	(set "NOTEPADPP_IMPORT=https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.x64.zip")
	if not defined NOTEPADPP_IMPORT	(%dk_call% dk_error "NOTEPADPP_IMPORT is invalid")
	
	%dk_call% dk_basename %NOTEPADPP_IMPORT% NOTEPADPP_IMPORT_FILE
	%dk_call% dk_removeExtension %NOTEPADPP_IMPORT_FILE% NOTEPADPP_FOLDER
    %dk_call% dk_toLower %NOTEPADPP_FOLDER% NOTEPADPP_FOLDER
	::%dk_call% dk_importVariables %CMAKE_DL%
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"	
	%dk_call% dk_set NOTEPADPP_DIR "%DKTOOLS_DIR%/%NOTEPADPP_FOLDER%"
	%dk_call% dk_set NOTEPADPP_EXE "%NOTEPADPP_DIR%/notepad++.exe"
	
	if exist "%NOTEPADPP_EXE%" (goto installed)
	    %dk_call% dk_echo   
        %dk_call% dk_info "Installing notepad++ . . ."
        %dk_call% dk_download %NOTEPADPP_IMPORT%
	    %dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
        %dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%\%NOTEPADPP_IMPORT_FILE%" "%NOTEPADPP_DIR%"
	if NOT exist "%NOTEPADPP_EXE%" (%dk_call% dk_error "cannot find NOTEPADPP_EXE:%NOTEPADPP_EXE%")
	:installed
	
	::### Add Dark Mode ###
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_copy "%DKIMPORTS_DIR%/notepadpp/dark_config.xml" "%NOTEPADPP_DIR%/config.xml" OVERWRITE
	
	::### Add Context Menu ###
	%dk_call% "%DKIMPORTS_DIR%/notepadpp/contextMenu/DKINSTALL.cmd"
	
	::### Add File Associations ###
	::%dk_call% %DKIMPORTS_DIR%/notepadpp/fileAssoc/DKINSTALL.cmd
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%

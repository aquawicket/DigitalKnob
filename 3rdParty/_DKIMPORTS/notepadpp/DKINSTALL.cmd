@echo off&::###### DK.cmd #########################################################################################################################
if NOT exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_import APP
	
	set "NOTEPADPP_EXE=%NOTEPADPP%/notepad++.exe"
	
	::### Add Dark Mode ###
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_copy "%DKIMPORTS_DIR%/notepadpp/dark_config.xml" "%NOTEPADPP%/config.xml" OVERWRITE
	
	::### Add Context Menu ###
	%dk_call% dk_depend notepadpp/contextMenu
	
	::### Add File Associations ###
	::%dk_call% dk_depend notepadpp/fileAssoc
	
%endfunction%	
	
::	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
::	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
::	set "NOTEPADPP_IMPORT=!NotepadPP_%Host_Tuple%_Import!"
::	%dk_call% dk_assertVar NOTEPADPP_IMPORT
::	
::	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
::	%dk_call% dk_importVariables %NOTEPADPP_IMPORT% ROOT %DKTOOLS_DIR%
::	
::	::%dk_call% dk_set NOTEPADPP_DIR "%DKTOOLS_DIR%/%NOTEPADPP_FOLDER%"
::	%dk_call% dk_set NOTEPADPP_EXE "%NOTEPADPP%/notepad++.exe"
::	
::	if exist "%NOTEPADPP_EXE%" (goto installed)
::	
::	%dk_call% dk_echo  
::  %dk_call% dk_info "Installing notepad++ . . ."
::	%dk_call% dk_download %NOTEPADPP_IMPORT%
::	%dk_call% dk_smartExtract "%dk_download%" "%NOTEPADPP%"
::	%dk_call% dk_assertPath NOTEPADPP_EXE
::	:installed
::	
::	::### Add Dark Mode ###
::	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
::	%dk_call% dk_copy "%DKIMPORTS_DIR%/notepadpp/dark_config.xml" "%NOTEPADPP%/config.xml" OVERWRITE
::	
::	::### Add Context Menu ###
::	%dk_call% dk_depend notepadpp/contextMenu"
::	
::	::### Add File Associations ###
::	::%dk_call% dk_depend notepadpp/fileAssoc
::%endfunction%

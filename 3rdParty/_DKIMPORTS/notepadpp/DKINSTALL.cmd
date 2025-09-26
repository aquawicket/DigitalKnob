@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_import APP
	
	set "notepadpp_exe=%notepadpp%/notepad++.exe"
	
	::### Add Dark Mode ###
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_copy "%DKIMPORTS_DIR%/notepadpp/dark_config.xml" "%notepadpp%/config.xml" OVERWRITE
	
	::### Add Context Menu ###
	%dk_call% dk_depend notepadpp/contextMenu
	
	::### Add File Associations ###
	::%dk_call% dk_depend notepadpp/fileAssoc
	
%endfunction%	
	
::	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
::	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
::	set "notepadpp_Import=!notepadpp_%Host_Tuple%_Import!"
::	%dk_call% dk_assertVar notepadpp_Import
::	
::	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
::	%dk_call% dk_importVariables %notepadpp_Import% ROOT %DKTOOLS_DIR%
::	
::	::%dk_call% dk_set notepadpp_DIR "%DKTOOLS_DIR%/%notepadpp_FOLDER%"
::	%dk_call% dk_set notepadpp_exe "%notepadpp%/notepad++.exe"
::	
::	if EXIST "%notepadpp_exe%" (goto installed)
::	
::	%dk_call% dk_echo  
::  %dk_call% dk_info "Installing notepad++ . . ."
::	%dk_call% dk_download %notepadpp_Import%
::	%dk_call% dk_smartExtract "%dk_download%" "%notepadpp%"
::	%dk_call% dk_assertPath notepadpp_exe
::	:installed
::	
::	::### Add Dark Mode ###
::	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
::	%dk_call% dk_copy "%DKIMPORTS_DIR%/notepadpp/dark_config.xml" "%notepadpp%/config.xml" OVERWRITE
::	
::	::### Add Context Menu ###
::	%dk_call% dk_depend notepadpp/contextMenu"
::	
::	::### Add File Associations ###
::	::%dk_call% dk_depend notepadpp/fileAssoc
::%endfunction%

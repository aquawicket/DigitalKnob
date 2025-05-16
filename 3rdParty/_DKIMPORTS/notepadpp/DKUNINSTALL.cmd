@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# DKUNINSTALL()
::#
:DKUNINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	if defined Win_Arm64_Host	(set "NOTEPADPP_IMPORT=https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.arm64.zip")
    if defined Win_X86_Host		(set "NOTEPADPP_IMPORT=https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.zip")
    if defined Win_X86_64_Host	(set "NOTEPADPP_IMPORT=https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.x64.zip")
	if not defined NOTEPADPP_IMPORT	(%dk_call% dk_error "NOTEPADPP_IMPORT is invalid")
	
	%dk_call% dk_basename %NOTEPADPP_IMPORT% NOTEPADPP_IMPORT_FILE
	%dk_call% dk_removeExtension %NOTEPADPP_IMPORT_FILE% NOTEPADPP_FOLDER
	::%dk_call% dk_convertToCIdentifier %NOTEPADPP_FOLDER% NOTEPADPP_FOLDER
	%dk_call% dk_toLower %NOTEPADPP_FOLDER% NOTEPADPP_FOLDER
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_set NOTEPADPP_DIR "%DKTOOLS_DIR%/%NOTEPADPP_FOLDER%"

	::FIXME: kill notepad++.exe process
	%dk_call% dk_delete "%NOTEPADPP_DIR%"
	
	::### Uninstall Context Menu ###
	%dk_call% "%DKIMPORTS_DIR%/notepadpp/contextMenu/DKUNINSTALL.cmd"

	::### Uninstall File Associations ###
	%dk_call% "%DKIMPORTS_DIR%/notepadpp/fileAssoc/DKUNINSTALL.cmd"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
 
    %dk_call% DKUNINSTALL
%endfunction%

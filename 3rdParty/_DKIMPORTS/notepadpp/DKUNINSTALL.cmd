@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKUNINSTALL()
::#
:DKUNINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
	
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	if defined Windows_Arm64_Host	(set "NOTEPADPP_IMPORT=%NOTEPADPP_Windows_Arm64_IMPORT%")
    if defined Windows_X86_Host		(set "NOTEPADPP_IMPORT=%NOTEPADPP_Windows_X86_IMPORT%")
    if defined Windows_X86_64_Host	(set "NOTEPADPP_IMPORT=%NOTEPADPP_Windows_X86_64_IMPORT%")
	if not defined NOTEPADPP_IMPORT	(%dk_call% dk_error "NOTEPADPP_IMPORT is invalid")
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables %NOTEPADPP_IMPORT% ROOT %DKTOOLS_DIR%

	::### Uninstall Context Menu ###
	%dk_call% "%DKIMPORTS_DIR%/notepadpp/contextMenu/DKUNINSTALL.cmd"

	::### Uninstall File Associations ###
	%dk_call% "%DKIMPORTS_DIR%/notepadpp/fileAssoc/DKUNINSTALL.cmd"
	
	::FIXME: kill notepad++.exe process
	%dk_call% dk_delete "%NOTEPADPP%"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    %dk_call% DKUNINSTALL
%endfunction%

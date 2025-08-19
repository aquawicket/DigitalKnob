@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKUNINSTALL()
::#
:DKUNINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables !notepadpp_%Host_Tuple%_Import! INSTALL_ROOT %DKTOOLS_DIR%

	::### Uninstall Context Menu ###
	%dk_call% dk_uninstall notepadpp/contextMenu
	
	::### Uninstall File Associations ###
	%dk_call% dk_uninstall notepadpp/fileAssoc
	
	::FIXME: kill notepad++.exe process
	%dk_call% dk_delete "%NOTEPADPP%"
%endfunction%


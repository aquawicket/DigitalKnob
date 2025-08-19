@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
%setlocal%
	%dk_call% dk_debugFunc 0
	
	::############ Try local notepad++.exe in DKTools first #############
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	if NOT EXIST "%NOTEPADPP_EXE%" (%dk_call% dk_findProgram NOTEPADPP_EXE "notepad++.exe" "%DKTOOLS_DIR%" NO_ERROR)
	
	if NOT EXIST "%NOTEPADPP_EXE%" (%dk_call% dk_findProgram NOTEPADPP_EXE "notepad++.exe" "%ProgramFiles%")

	::############ Install Notepad++ ############
	::%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	::%dk_call% dk_validate NOTEPADPP_EXE "%dk_call% dk_depend notepadpp"
	
::	if NOT EXIST "%NOTEPADPP_EXE%" (
::		%dk_call% dk_error "could NOT find notepad++.exe.  is it installed?"
::		%return%
::	)

	%dk_call% dk_installContextMenu "Edit with Notepad++" "%NOTEPADPP_EXE%" "%NOTEPADPP_EXE:/=\% %%%%%%%%1"
%endfunction%


@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
%setlocal%
	%dk_call% dk_debugFunc 0
	
	::############ Try local notepad++.exe in DKTools first #############
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	if not exist "%NOTEPADPP_EXE%" (%dk_call% dk_findProgram NOTEPADPP_EXE "notepad++.exe" "%DKTOOLS_DIR%")
	
	if not exist "%NOTEPADPP_EXE%" (%dk_call% dk_findProgram NOTEPADPP_EXE "notepad++.exe" "%ProgramFiles%")
	
	::############ Install Notepad++ ############
	::%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	::%dk_call% dk_validate NOTEPADPP_EXE "%dk_call% %DKIMPORTS_DIR%/notepadpp/DKINSTALL.cmd"
	
	if not exist "%NOTEPADPP_EXE%" (
		%dk_call% dk_error "could not find notepad++.exe.  is it installed?"
		%return%
	)
	
	%dk_call% dk_installContextMenu "Edit with Notepad++" "%NOTEPADPP_EXE%" "%NOTEPADPP_EXE:/=\% %%%%%%%%1"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
    %dk_call% DKINSTALL
%endfunction%

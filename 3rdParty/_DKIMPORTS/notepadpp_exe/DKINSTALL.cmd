@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
::#
:DKINSTALL
%setlocal%
	%dk_call% dk_debugFunc 0
  
    if EXIST "%notepadpp_exe%" (%return%)
   
	::###### search for notepad++.exe in 'DKTOOLS_DIR' ######
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_findProgram notepadpp_exe "notepad++.exe" "%DKTOOLS_DIR%" NO_HALT

    ::###### search for notepad.exe on 'C:/Program Files' ######
	if NOT EXIST "%notepadpp_exe%" (%dk_call% dk_findProgram notepadpp_exe "notepad++.exe" "%ProgramFiles%")

	endlocal & (
		set "notepadpp_exe=%notepadpp_exe:\=/%"
	)
	
	%dk_call% dk_assertPath "%notepadpp_exe%"
%endfunction%



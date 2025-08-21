@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_NOTEPADPP_EXE()
::#
::#
:dk_NOTEPADPP_EXE
%setlocal%
	%dk_call% dk_debugFunc 0
  
    if EXIST "%NOTEPADPP_EXE%" (%return%)
   
	::###### search for notepad++.exe in 'DKTOOLS_DIR' ######
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_findProgram NOTEPADPP_EXE "notepad++.exe" "%DKTOOLS_DIR%" NO_HALT

    ::###### search for notepad.exe on 'C:/Program Files' ######
	if NOT EXIST "%NOTEPADPP_EXE%" (%dk_call% dk_findProgram NOTEPADPP_EXE "notepad++.exe" "%ProgramFiles%")

	endlocal & (
		set "NOTEPADPP_EXE=%NOTEPADPP_EXE:\=/%"
	)
	
	%dk_call% dk_assertPath "%NOTEPADPP_EXE%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate NOTEPADPP_EXE "%dk_call% dk_NOTEPADPP_EXE"
    %dk_call% dk_echo "NOTEPADPP_EXE = %NOTEPADPP_EXE%"
%endfunction%

@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_NOTEPADPP_EXE()
::#
::#
:dk_NOTEPADPP_EXE
setlocal
	%dk_call% dk_debugFunc 0
   
    if exist %NOTEPADPP_EXE% (%return%)
    
	::###### search for notepad++.exe in 'DKTOOLS_DIR' ######
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_findProgram NOTEPADPP_EXE "notepad++.exe" "%DKTOOLS_DIR%" NO_HALT

    ::###### search for notepad.exe on 'C:/Program Files' ######
	if not exist "%NOTEPADPP_EXE%" (%dk_call% dk_findProgram NOTEPADPP_EXE "notepad++.exe" "%ProgramFiles%")
	%dk_call% dk_assertPath "%NOTEPADPP_EXE%"
	
	endlocal & (
		set "NOTEPADPP_EXE=%NOTEPADPP_EXE%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate NOTEPADPP_EXE "%dk_call% dk_NOTEPADPP_EXE"
    %dk_call% dk_echo "NOTEPADPP_EXE = %NOTEPADPP_EXE%"
%endfunction%

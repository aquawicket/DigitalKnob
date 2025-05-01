@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::############################################################################
::# dk_dumpAllVariables(file)
::#
:dk_dumpAllVariables
%setlocal%
	%dk_call% dk_debugFunc 1
	
	set "_file_=%~1"

	for %%f in ("%_file_%") do (
        start /i /wait /min "" "%ComSpec%" /c">""%%~ff"" set "	
    )
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    %dk_call% dk_dumpAllVariables "C:/Users/Administrator/digitalknob/variables.txt"
%endfunction%

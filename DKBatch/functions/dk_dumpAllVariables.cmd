@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::############################################################################
::# dk_dumpAllVariables(file)
::#
:dk_dumpAllVariables
setlocal
	%dk_call% dk_debugFunc 1
	
	set "_file_=%~1"

	for %%f in ("%_file_%") do (
        start /i /wait /min "" "%COMSPEC%" /c">""%%~ff"" set "	
    )
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_dumpAllVariables "C:/Users/Administrator/digitalknob/variables.txt"
%endfunction%

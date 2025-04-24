<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::############################################################################
::# dk_dumpAllVariables(file)
::#
:dk_dumpAllVariables
<<<<<<< HEAD
    call dk_debugFunc 1
 setlocal
 
	for %%f in ("%~1") do (
        start /i /wait /min "" "%comspec%" /c">""%%~ff"" set "	
=======
setlocal
	%dk_call% dk_debugFunc 1
	
	set "_file_=%~1"

	for %%f in ("%_file_%") do (
        start /i /wait /min "" "%ComSpec%" /c">""%%~ff"" set "	
>>>>>>> Development
    )
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_dumpAllVariables "variables.txt"
=======
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_dumpAllVariables "C:/Users/Administrator/digitalknob/variables.txt"
>>>>>>> Development
%endfunction%

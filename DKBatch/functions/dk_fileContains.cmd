<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::##################################################################################
::# dk_fileContains(file, string)
::#
::#
:dk_fileContains
    call dk_debugFunc 2
 setlocal
 
    >nul findstr /c:"%~2" "%~1" &&  (
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::##################################################################################
::# dk_fileContains(<file>, <string>, optional:<rtn_var>)
::#
::#
:dk_fileContains
setlocal
	%dk_call% dk_debugFunc 2 3

	set "_file_=%~1"
	set "_file_=%_file_:/=\%"
	
    >nul findstr /c:"%~2" "%_file_%" &&  (
>>>>>>> Development
        if "%~3" neq "" (endlocal & set "%3=true")
        exit /b 0
    )
    
    if "%~3" neq "" (endlocal & set "%3=false")
    exit /b 1
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
=======
setlocal
	%dk_call% dk_debugFunc 0

>>>>>>> Development
    :: create test
    %dk_call% dk_fileAppend fileContains_TEST.txt "find the needle in the haystack"
    
    :: test
    %dk_call% dk_echo
    %dk_call% dk_set substring needle
    %dk_call% dk_fileContains fileContains_TEST.txt "%substring%" && (echo file contains substring) || (echo file does NOT contain substring)
    
    %dk_call% dk_echo
    %dk_call% dk_set substring "not_in_file"
    %dk_call% dk_fileContains fileContains_TEST.txt "%substring%" && (echo file contains substring) || (echo file does NOT contain substring)
%endfunction%

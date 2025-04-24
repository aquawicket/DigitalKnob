<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::####################################################################
::# dk_BASH_EXE()
::#
::#
:dk_BASH_EXE
<<<<<<< HEAD
    call dk_debugFunc 0
:: setlocal
   
    if defined BASH_EXE %return%
    
	:: try Git for windows bash.exe
	%dk_call% dk_validate GIT "%dk_call% dk_installGit"
	%dk_call% dk_findProgram BASH_EXE "bash.exe" "%GIT%"
	if defined BASH_EXE %return%

=======
setlocal
	%dk_call% dk_debugFunc 0

	if exist "%BASH_EXE%" (%return%)

	%dk_call% dk_validate GIT "%dk_call% dk_installGit"
	if not exist "%BASH_EXE%" (%dk_call% dk_findProgram BASH_EXE "bash.exe" "%GIT%")
	%dk_call% dk_assertPath "%BASH_EXE%"
	
	endlocal & (
		set "BASH_EXE=%BASH_EXE%"
	)
>>>>>>> Development
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_BASH_EXE
    %dk_call% dk_printVar BASH_EXE
=======
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_BASH_EXE
	%dk_call% dk_echo "BASH_EXE = '%BASH_EXE%'"
>>>>>>> Development
%endfunction%

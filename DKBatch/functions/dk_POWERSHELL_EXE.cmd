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
::# dk_POWERSHELL_EXE()
::#
::#
:dk_POWERSHELL_EXE
<<<<<<< HEAD
    call dk_debugFunc 0
:: setlocal
   
    if defined POWERSHELL_EXE %return%
    
	:: try pwsh.exe
    %dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DIGITALKNOB_DIR"
    %dk_call% dk_findProgram POWERSHELL_EXE "pwsh.exe" "%DKTOOLS_DIR%"
	if defined POWERSHELL_EXE %return%
    
    :: try powershell.exe
    %dk_call% dk_findProgram POWERSHELL_EXE "powershell.exe"
    if defined POWERSHELL_EXE %return%
=======
setlocal
	%dk_call% dk_debugFunc 0
   
    if exist %POWERSHELL_EXE% (%return%)
    
	::###### try pwsh.exe ######
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_findProgram POWERSHELL_EXE "pwsh.exe" "%DKTOOLS_DIR%" NO_HALT

    ::###### try powershell.exe ######
	if not exist "%POWERSHELL_EXE%" (%dk_call% dk_findProgram POWERSHELL_EXE "powershell.exe" "%WINDIR:\=/%/System32")
	%dk_call% dk_assertPath "%POWERSHELL_EXE%"
	
	endlocal & (
		set "POWERSHELL_EXE=%POWERSHELL_EXE%"
	)
>>>>>>> Development
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_POWERSHELL_EXE
    %dk_call% dk_printVar POWERSHELL_EXE
=======
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"
    %dk_call% dk_echo "POWERSHELL_EXE = %POWERSHELL_EXE%"
>>>>>>> Development
%endfunction%

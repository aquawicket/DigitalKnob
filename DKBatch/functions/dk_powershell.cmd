<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::################################################################################
::# dk_powershell(commands)
::#
::#
:dk_powershell
    if defined dk_powershell (echo dk_powershell blocked && %return%) else (set "dk_powershell=1")   &::disallow recursion for this function
<<<<<<< HEAD
    call dk_debugFunc 0 99
 setlocal

	%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"
	%dk_call% dk_assertVar POWERSHELL_EXE
    
::    :: try pwsh.exe
::    %dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DIGITALKNOB_DIR"
=======
setlocal
	%dk_call% dk_debugFunc 0 99

	%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"
	%dk_call% dk_assertPath POWERSHELL_EXE
    
::    :: try pwsh.exe
::    %dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
>>>>>>> Development
::    %dk_call% dk_findProgram POWERSHELL_EXE "pwsh.exe" "%DKTOOLS_DIR%"
::	if defined POWERSHELL_EXE "%POWERSHELL_EXE%" /? %NO_OUTPUT% && goto found	
    
::    :: try powershell.exe
::    %dk_call% dk_findProgram POWERSHELL_EXE "powershell.exe"
::    if defined POWERSHELL_EXE "%POWERSHELL_EXE%" /? %NO_OUTPUT% && goto found

::    :: install pwsh.exe and try again
<<<<<<< HEAD
::    %dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKBRANCH_DIR"
::    if not exist "%DKIMPORTS_DIR%" %dk_call% dk_notice "DKIMPORTS not found" && exit /b 1
::    call "%DKIMPORTS_DIR%\powershell\dk_installPowershell.cmd"
=======
::    %dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
::    if not exist "%DKIMPORTS_DIR%" %dk_call% dk_notice "DKIMPORTS not found" && exit /b 1
::    %dk_call% "%DKIMPORTS_DIR%\powershell\DKINSTALL.cmd"
>>>>>>> Development
::    %dk_call% dk_findProgram POWERSHELL_EXE "pwsh.exe" "%DKTOOLS_DIR%"
::    if defined POWERSHELL_EXE "%POWERSHELL_EXE%" /? %NO_OUTPUT% && goto found
    
::    :notfound
::    %dk_call% dk_fatal "POWERSHELL_EXE invalid"
::    %return%
      
::   :found
<<<<<<< HEAD
    if "%~1"=="" %return%
    %dk_call% dk_printVar POWERSHELL_EXE
    "%POWERSHELL_EXE%" -Command %*
    
	::function complete, remove recursion block
    set "dk_powershell="
=======
    if "%~1" equ "" (%return%)
	
	::###### run command ######
	set DKPOWERSHELL_COMMAND="%POWERSHELL_EXE%" -Command %*
	echo "DKPOWERSHELL_COMMAND = %DKPOWERSHELL_COMMAND%"
	
	call dk_exec "%DKPOWERSHELL_COMMAND%"
	endlocal & (
		set "dk_powershell=%dk_exec%"
	)
	
	(set "dk_powershell=")
>>>>>>> Development
%endfunction%



<<<<<<< HEAD

::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
	%dk_call% dk_powershell "Write-Output 'testing dk_powershell'"
    ::%dk_call% dk_powershell "$PSVAR='this is a powershell variable'; Write-Output 'testing dk_powershell(): ${PSVAR}'"
=======
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_powershell Write-Output 'dk_powershell TEST A';
	
	%dk_call% dk_powershell "Write-Output 'dk_powershell TEST B';"
	
	setlocal disableDelayedExpansion & set "ps_command=${PSVAR}='this is a powershell variable'; Write-Output 'testing dk_powershell ${PSVAR}';" & setlocal enableDelayedExpansion

    %dk_call% dk_powershell "!ps_command!"

>>>>>>> Development
%endfunction%

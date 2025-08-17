@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_powershell(commands)
::#
::#
:dk_powershell
    ::if defined dk_powershell (echo dk_powershell blocked && %return%) else (set "dk_powershell=1")   &::disallow recursion for this function
%setlocal%
	::%dk_call% dk_debugFunc 0 99
	if "%~1" equ "" (%return%)
	
	set dk_powershell_command=%*
	:DeEscape
	echo %dk_powershell_command% | findstr /c:"^^" >nul && (
		set dk_powershell_command=%dk_powershell_command:^^=^%
		goto :DeEscape
	)
	
::	%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"
	set "POWERSHELL_EXE=powershell.exe"
  
::    :: try pwsh.exe
::    %dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
::    %dk_call% dk_findProgram POWERSHELL_EXE "pwsh.exe" "%DKTOOLS_DIR%"
::	if defined POWERSHELL_EXE "%POWERSHELL_EXE%" /? %NO_OUTPUT% && goto found	
   
::    :: try powershell.exe
::    %dk_call% dk_findProgram POWERSHELL_EXE "powershell.exe"
::    if defined POWERSHELL_EXE "%POWERSHELL_EXE%" /? %NO_OUTPUT% && goto found

::    :: install pwsh.exe and try again
::    %dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
::    if not exist "%DKIMPORTS_DIR%" %dk_call% dk_notice "DKIMPORTS not found" && exit /b 1
::    %dk_call% "dk_depend powershell"
::    %dk_call% dk_findProgram POWERSHELL_EXE "pwsh.exe" "%DKTOOLS_DIR%"
::    if defined POWERSHELL_EXE "%POWERSHELL_EXE%" /? %NO_OUTPUT% && goto found
   
::    :notfound
::    %dk_call% dk_fatal "POWERSHELL_EXE invalid"
::    %return%
     
::   :found
    
	
	::###### run command ######
	set DKPOWERSHELL_COMMAND=%POWERSHELL_EXE% -Command %dk_powershell_command%
	::echo "DKPOWERSHELL_COMMAND = %DKPOWERSHELL_COMMAND%"
	
	%dk_call% dk_exec %DKPOWERSHELL_COMMAND%
	
	endlocal & (
		set "dk_powershell=%dk_exec%"
	)
	
::	(set "dk_powershell=")
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	echo ######################## TEST_A ########################
	%dk_call% dk_powershell "Write-Output 'dk_powershell TEST A';"
	echo(
	
	echo ######################## TEST_B ########################
	%dk_call% dk_powershell "Write-Output 'dk_powershell TEST B';"
	echo(
	
	echo ######################## TEST_C ########################
	set "PSVAR=this is a powershell variable"
    %dk_call% dk_powershell "Write-Output 'PSVAR = '${env:PSVAR};"
	echo(
	
%endfunction%

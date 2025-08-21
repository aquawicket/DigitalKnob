@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_POWERSHELL_EXE()
::#
::#
:dk_POWERSHELL_EXE
%setlocal%
	%dk_call% dk_debugFunc 0
  
    if EXIST "%POWERSHELL_EXE%" (%return%)

	::###### try pwsh.exe ######
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_findProgram POWERSHELL_EXE pwsh.exe "%DKTOOLS_DIR%" NO_ERROR

    ::###### try powershell.exe ######
	if NOT EXIST "%POWERSHELL_EXE%" (%dk_call% dk_findProgram POWERSHELL_EXE "powershell.exe")
	
	if NOT EXIST "%POWERSHELL_EXE%" (
		%dk_call% dk_exec cmd /c where powershell.exe
		set "POWERSHELL_EXE=!dk_exec!"
	)
	
	::if NOT EXIST "%POWERSHELL_EXE%" (%dk_call% dk_findProgram POWERSHELL_EXE "powershell.exe" "%windir%/System32")
	::%dk_call% dk_assertPath "%POWERSHELL_EXE%"
	(call )
	endlocal & (
		set "POWERSHELL_EXE=%POWERSHELL_EXE%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE" %NOERROR%
	if NOT EXIST "%POWERSHELL_EXE%" (%dk_call% dk_POWERSHELL_EXE)
    %dk_call% dk_echo "POWERSHELL_EXE = %POWERSHELL_EXE%"
%endfunction%

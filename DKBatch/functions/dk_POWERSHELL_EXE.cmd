@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_POWERSHELL_EXE()
::#
::#
:dk_POWERSHELL_EXE
setlocal
	%dk_call% dk_debugFunc 0
   
    if exist %POWERSHELL_EXE% (%return%)
    
	::###### try pwsh.exe ######
    if not exist "%POWERSHELL_EXE%" (
		%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
		%dk_call% dk_findProgram POWERSHELL_EXE "pwsh.exe" "%DKTOOLS_DIR%"
	)

    ::###### try powershell.exe ######
	if not exist "%POWERSHELL_EXE%" (
		%dk_call% dk_findProgram POWERSHELL_EXE powershell.exe
	)
	
	endlocal & (
		set "POWERSHELL_EXE=%POWERSHELL_EXE%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"
    %dk_call% dk_echo "POWERSHELL_EXE = %POWERSHELL_EXE%"
%endfunction%

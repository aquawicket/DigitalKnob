@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_REG_EXE()
::#
::#
:dk_REG_EXE
setlocal
	%dk_call% dk_debugFunc 0
   
    if exist "%REG_EXE%" %return%

	if not exist "%REG_EXE%"  set "REG_EXE=C:/Windows/System32/reg.exe"
	if not exist "%REG_EXE%"  %dk_call% dk_findProgram REG_EXE "reg.exe" "%WINDIR%/System32"
	
	endlocal & (
		set "REG_EXE=%REG_EXE%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_REG_EXE
    %dk_call% dk_printVar REG_EXE
%endfunction%

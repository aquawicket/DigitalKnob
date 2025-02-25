@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_assertPath(path)
::#
:dk_assertPath
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 0 99
	
	set "_path_=%*"
	if exist %_path_:/=\%	(exit /b 0)
	
	if defined %~1 (set "_path_=!%~1!")
	if exist "%_path_:/=\%"	(exit /b 0)
	
    %dk_call% dk_error "ASSERTION: dk_assertPath(%*): path not found!"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	::# correct path
	%dk_call% dk_assertPath "C:\Program Files\Common Files"			&::OK
	::# foward slashes
	%dk_call% dk_assertPath "C:/Program Files/Common Files"			&::OK
	::# lower case
	%dk_call% dk_assertPath "c:/program files/common files"			&::OK
	::# UPPER CASE
	%dk_call% dk_assertPath "C:/PROGRAM FILES/COMMON FILES"			&::OK
	::# No quotes
	%dk_call% dk_assertPath C:/PROGRAM FILES/COMMON FILES			&::OK
	::# as Variable
   
   %dk_call% dk_set myPath "C:/Program Files/Common Files"
	::# As a variable with %_%
    %dk_call% dk_assertPath "%myPath%"								&::OK		
	::# As a variable with %_% without quotes
	%dk_call% dk_assertPath %myPath%								&::OK		
	::# As a variable with !_!
    %dk_call% dk_assertPath "!myPath!"								&::OK
	::# As a variable with !_! without quotes
    %dk_call% dk_assertPath !myPath!								&::OK
	::# As a variable name
    %dk_call% dk_assertPath myPath									&::OK
	::# As a variable name quoted
    %dk_call% dk_assertPath "myPath"								&::OK
	::# CMD.exe
	%dk_call% dk_assertPath "%COMSPEC%"								&::OK
	
	
    %dk_call% dk_assertPath "C:/NonExistentPath"					&::ASSERT
%endfunction%

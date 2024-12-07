@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

if exist !%1!  %return%
if "!DE!" neq "" %dk_call% dk_fatal "%~0 requires delayed expansion"
::################################################################################
::# dk_assertPath(path)
::#
:dk_assertPath
    call dk_debugFunc 0 99
 setlocal
	
	:: check that ARG1 is valid
	if "%~1" equ "" %dk_call% dk_fatal "dk_assertPath(%*): ARG1 is invalid"
	
	:: get the name of the variable
	if defined %~1 (set "_name_=%1:") else (set "_name_=path:")
	
	:: check that the path has quotes
	set "_path_=%1"
	if "" neq %_path_:~0,1%%_path_:~-1% (
		if not defined %~1 	%dk_call% dk_error "dk_assertPath(%*): path is not quoted"
	) else (
		if defined %~1  %dk_call% dk_error "dk_assertPath(%*): don't quote variable names"
	)
	
	:: check that we only recieved 1 argument
	if "%~2" neq ""  %dk_call% dk_error "dk_assertPath(%*): too many arguments"
	
	:: Without Delayed Expansion
    ::set "_var_=%~1"
    ::if "!DE!" neq "" call set "_value_=%%%_var_%%%"
	::echo dk_assertPath %_value_%
    %dk_call% dk_error "ASSERTION: dk_assertPath(%*): path not found!"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
	::# correct path
	%dk_call% dk_assertPath "C:\Program Files\Common Files"			&::OK
	::# forward slashes 
	%dk_call% dk_assertPath "C:/Program Files/Common Files"			&::OK
	::# lower case
	%dk_call% dk_assertPath "c:\program files\common files"			&::OK
	::# UPPER CASE
	%dk_call% dk_assertPath "C:\PROGRAM FILES\COMMON FILES"			&::OK
	
    %dk_call% dk_set myPath "C:\Program Files\Common Files"
	::# As a variable with %'s
    %dk_call% dk_assertPath "%myPath%"								&::OK		
	::# As a variable with !'s
    %dk_call% dk_assertPath "!myPath!"								&::OK
	::# As a variable name
    %dk_call% dk_assertPath myPath									&::OK
	
	
	
	%return%
	::# As a variable name quoted
    %dk_call% dk_assertPath "myPath"								&::NOT OK - no "quotes" around variable names
	::# unquoted
	%dk_call% dk_assertPath C:\Windows							    &::NOT OK - must be wrapped in "quotes"
	::# As a variable unquoted
    %dk_call% dk_assertPath %myPath%								&::NOT OK - must have "quotes around vaiables"
	::# Non Existent Path
    %dk_call% dk_assertPath "C:\NonExistentPath"					&::ASSERT
%endfunction%

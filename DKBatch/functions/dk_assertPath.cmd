<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

if exist !%1!  %return%
if "!DE!" neq "" %dk_call% dk_fatal "%~0 requires delayed expansion"
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::##################### dk_assertPath Options ####################################
set "dk_assertPath_FORWARD_SLASHES=1"
set "dk_assertPath_CASE_SENSITIVE=1"
>>>>>>> Development
::################################################################################
::# dk_assertPath(path)
::#
:dk_assertPath
<<<<<<< HEAD
    call dk_debugFunc 0 99
 setlocal
	
	:: check that ARG1 is valid
	if "%~1" equ "" %dk_call% dk_fatal "dk_assertPath(%*): ARG1 is invalid"
	
	:: get the name of the variable
	if defined %~1 (set "_name_=%1:") else (set "_name_=path:")
	
	:: check that the path has quotes
	set "_path_=%1"
	if "" neq %_path_:~0,1%%_path_:~-1% (
		if not defined %~1 (
			!dk_call! dk_error "dk_assertPath(%*): path is not quoted"
		)
	) else (
		if defined %~1 (
			!dk_call! dk_error "dk_assertPath(%*): don't quote variable names"
		)
	)
	
	:: check that we only recieved 1 argument
	if "%~2" neq "" (
		!dk_call! dk_error "dk_assertPath(%*): too many arguments"
	)
	
	:: Without Delayed Expansion
    ::set "_var_=%~1"
    ::if "!DE!" neq "" call set "_value_=%%%_var_%%%"
	::echo dk_assertPath %_value_%
    !dk_call! dk_error "ASSERTION: dk_assertPath(%*): path not found!"
%endfunction%

=======
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 0 99

	::### var/val path from all arguments ###
	(set _val_=%*)
	(set _var_=%_val_%)
	(set _var_=%_var_:(=%)
	(set _var_=%_var_:)=%)
	(set _var_=%_var_:"=%)
	(set _var_=%_var_: =%)
	if defined %_var_% (set _val_="!%_var_:"=%!") else (set "_var_=path")
	set _val_="%_val_:"=%"


	for %%Z in ("%_val_:"=%") do (set _real_="%%~fZ")

	if defined dk_assertPath_FORWARD_SLASHES set "_real_=%_real_:\=/%"

	::### Test case sensitive ###
	if defined dk_assertPath_CASE_SENSITIVE if not [%_val_%]==[%_real_%] echo %red% %_var_%:'%_val_%' _real_:'%_real_%' mismatch %clr% & %return%

	::### Test path exists ###
	if not exist "%_val_:"=%" %dk_call% dk_error "ASSERTION: dk_assertPath %_var_%:'%_val_:"=%' not found" & %return%

	if "%dk_DEBUG%" equ "1" %dk_call% dk_debug "dk_assertPath %_var_% = %_val_%"
%endfunction%
>>>>>>> Development






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
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
	
::	%return%
	::# As a variable name quoted
    %dk_call% dk_assertPath "myPath"								&::NOT OK
	::# unquoted
	%dk_call% dk_assertPath C:\Windows							    &::NOT OK
	::# As a variable unquoted
    %dk_call% dk_assertPath %myPath%								&::NOT OK
	::# Non Existent Path
    %dk_call% dk_assertPath "C:\NonExistentPath"					&::ASSERT
=======
setlocal
	%dk_call% dk_debugFunc 0

	::###### THESE SHOULD ALL BE FOUND ######

	::### Quoted ###
	%dk_call% dk_assertPath "C:/"		&::OK
	::# existing path w/ foward slashes
	%dk_call% dk_assertPath "C:/Program Files/Common Files"		&::OK
	::# existing path w/ trailing forwardslash
	%dk_call% dk_assertPath "C:/Program Files/Common Files/"	&::OK
	::# existing lower case path
	%dk_call% dk_assertPath "c:/program files/common files"		&::Case mismatch
	::# existing UPPER CASE path
	%dk_call% dk_assertPath "C:/PROGRAM FILES/COMMON FILES"		&::Case mismatch
	::# windows path
	%dk_call% dk_assertPath "C:\Program Files\Common Files"		&::Delimiter mismatch
	::# existing path w/ trailing backslash
	%dk_call% dk_assertPath "C:\Program Files\Common Files\"	&::Delimiter mismatch
	::# existing path w/ mixed slashes
	%dk_call% dk_assertPath "C:/Program Files\Common Files"		&::Delimiter mismatch
	::# existing path w/ double forwardslashes
	%dk_call% dk_assertPath "C://Program Files//Common Files"	&::Delimiter mismatch
	::# existing path w/ double backslashes
	%dk_call% dk_assertPath "C:\\Program Files\\Common Files"	&::Delimiter mismatch

	::### Quoted w/ special characters  i.e. ( and )
	::# foward slashes w/ special characters
	%dk_call% dk_assertPath "C:/Program Files (x86)/Common Files"	&::OK
	::# trailing forwardslash w/ special characters
	%dk_call% dk_assertPath "C:/Program Files (x86)/Common Files/"	&::OK
	::# lower case w/ special characters
	%dk_call% dk_assertPath "c:/program files (x86)/common files"	&::Case mismatch
	::# UPPER CASE w/ special characters
	%dk_call% dk_assertPath "C:/PROGRAM FILES (X86)/COMMON FILES"	&::Case mismatch
	::# windows path w/ special characters
	%dk_call% dk_assertPath "C:\Program Files (x86)\Common Files"	&::Delimiter mismatch
	::# trailing backslash w/ special characters
	%dk_call% dk_assertPath "C:\Program Files (x86)\Common Files\"	&::Delimiter mismatch
	::# existing path w/ mixed slashes
	%dk_call% dk_assertPath "C:/Program Files (x86)\Common Files"	&::Delimiter mismatch
	::# existing path w/ double forwardslashes
	%dk_call% dk_assertPath "C://Program Files (x86)//Common Files"	&::Delimiter mismatch
	::# existing path w/ double backslashes
	%dk_call% dk_assertPath "C:\\Program Files (x86)\\Common Files"	&::Delimiter mismatch

	::### Unquotes ###
	::# foward slashes
	%dk_call% dk_assertPath C:/Program Files/Common Files		&::OK
	::# trailing forwardslash
	%dk_call% dk_assertPath C:/Program Files/Common Files/		&::OK
	::# lower case
	%dk_call% dk_assertPath c:/program files/common files		&::Case mismatch
	::# UPPER CASE
	%dk_call% dk_assertPath C:/PROGRAM FILES/COMMON FILES		&::Case mismatch
	::# windows path
	%dk_call% dk_assertPath C:\Program Files\Common Files		&::Delimiter mismatch
	::# trailing backslash
	%dk_call% dk_assertPath C:\Program Files\Common Files\		&::Delimiter mismatch
	::# existing path w/ mixed slashes
	%dk_call% dk_assertPath C:/Program Files\Common Files		&::Delimiter mismatch
	::# existing path w/ double forwardslashes
	%dk_call% dk_assertPath C://Program Files//Common Files		&::Delimiter mismatch
	::# existing path w/ double backslashes
	%dk_call% dk_assertPath C:\\Program Files\\Common Files		&::Delimiter mismatch

	::### as variable ###
	set "myPath=C:/Program Files/Common Files"
	::# As a variable name
	%dk_call% dk_assertPath myPath									&::OK
	::# As a variable name quoted
	%dk_call% dk_assertPath "myPath"								&::OK
	::# as Variable quoted
	%dk_call% dk_assertPath "%myPath%"								&::OK
	::# As a variable using !_! quoted
	%dk_call% dk_assertPath "!myPath!"								&::OK
	::# As a variable without quotes
	%dk_call% dk_assertPath %myPath%								&::OK
	::# As a variable using !_! without quotes
	%dk_call% dk_assertPath !myPath!								&::OK

	::### as variable w/ special characters  i.e. ( and ) ###
	set "myPath=C:/Program Files (x86)/Common Files"
	::# As a variable name
	%dk_call% dk_assertPath myPath									&::OK
	::# As a quoted variable name
	%dk_call% dk_assertPath "myPath"								&::OK
	::# as a ariable using %'s quoted
	%dk_call% dk_assertPath "%myPath%"								&::OK
	::# As a variable using !'s quoted
	%dk_call% dk_assertPath "!myPath!"								&::OK
	::# As a variable without quotes
	::%dk_call% dk_assertPath %myPath%								&::CMD ERROR
	::# As a variable using !_! without quotes
	::%dk_call% dk_assertPath !myPath!								&::CMD ERROR

	::### Unquotes w/ special characters  i.e. ( and )
	::# foward slashes
	::%dk_call% dk_assertPath C:/Program Files (x86)/Common Files		&::CMD ERROR
	::# trailing forwardslash
	::%dk_call% dk_assertPath C:/Program Files (x86)/Common Files/		&::CMD ERROR
	::# lower case
	::%dk_call% dk_assertPath c:/program files (x86)/common files		&::CMD ERROR
	::# UPPER CASE
	::%dk_call% dk_assertPath C:/PROGRAM FILES (X86)/COMMON FILES		&::CMD ERROR
	::# windows path
	::%dk_call% dk_assertPath C:\Program Files (x86)\Common Files		&::CMD ERROR
	::# trailing backslash
	::%dk_call% dk_assertPath C:\Program Files (x86)\Common Files\		&::CMD ERROR

	::###### THESE SHOULD ALL BE (NOT FOUND) ######
	::# nonexistent path
	%dk_call% dk_assertPath "C:/NonExistent (x86)/Common Files"	&::ASSERT
	::# nonexistent lower case path
	%dk_call% dk_assertPath "c:/NonExistent (x86)/common files"	&::ASSERT
	::# nonexistent UPPER CASE path
	%dk_call% dk_assertPath "C:/NonExistent (x86)/COMMON FILES"	&::ASSERT
	::# nonexistent windows path
	%dk_call% dk_assertPath "C:\NonExistent (x86)\Common Files"	&::ASSERT
	::# nonexistent No quotes path
	::%dk_call% dk_assertPath C:/NonExistent (x86)/Common Files	&::CMD ERROR

>>>>>>> Development
%endfunction%

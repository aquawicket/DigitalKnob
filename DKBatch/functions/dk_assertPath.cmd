@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

set "STRICT_FORWARD_SLASHES=1"
set "STRICT_PATHS=1"
::################################################################################
::# dk_assertPath(path)
::#
:dk_assertPath
setlocal enableDelayedExpansion
	::echo dk_assertPath %*
	%dk_call% dk_debugFunc 0 99
	
	::### path from all arguments
	(set value=%*)
	(set var=%value%)
	(set var=%var:(=%)
	(set var=%var:)=%)
	(set var=%var:"=%)
	(set var=%var:^=%)
	(set var=%var:&=%)
	(set var=%var:<=%)
	(set var=%var:>=%)
	(set var=%var:|=%)
	(set var=%var:'=%)
	(set var=%var:`=%)
	(set var=%var:,=%)
	(set var=%var:;=%)
	(set var=%var:!=%)
	(set var=%var:\=%)
	(set var=%var:\=%)
	(set var=%var:[=%)
	(set var=%var:]=%)
	(set var=%var:.=%)
	(set var=%var:?=%)
	(set var=%var: =%)
	(set var=%var:	=%)
	::TODO: percent
	::TODO: equal
	::TODO: multiply
	if defined %var% (set value="!%var:"=%!")
	set value="%value:"=%"
	for %%Z in ("%value:"=%") do (set _real_="%%~fZ")
	
	if defined STRICT_FORWARD_SLASHES set "_real_=%_real_:\=/%"

	if defined STRICT_PATHS if not [%value%]==[%_real_%] (
		if defined %var% (echo %red% %var%:%value% %clr%) else (echo %red% %* %clr%)
		%return%
			
		echo %red%value = %value%
		echo _real_ = %_real_%
		%dk_call% dk_echo "ASSERTION: dk_assertPath path:'%value:"=%' path mismatch%clr%"
	)
	
	if exist "%value:"=%"	(
		if defined %var% (echo %green% %var%:%value% %clr%) else (echo %green% %* %clr%)
		%return%
	)
	
    %dk_call% dk_error "ASSERTION: dk_assertPath path:'%value:"=%' not found!"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	::###### THES SHOULD ALL BE FOUND ######
	
	::### Quotes ###
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
	
	::### Quotes w/ special characters  i.e. ( and )
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
	
	::### No Quotes ###
	::# foward slashes
	%dk_call% dk_assertPath C:/Program Files/Common Files	&::OK
	::# trailing forwardslash
	%dk_call% dk_assertPath C:/Program Files/Common Files/	&::OK
	::# lower case
	%dk_call% dk_assertPath c:/program files/common files	&::Case mismatch
	::# UPPER CASE
	%dk_call% dk_assertPath C:/PROGRAM FILES/COMMON FILES	&::Case mismatch
	::# windows path
	%dk_call% dk_assertPath C:\Program Files\Common Files	&::Delimiter mismatch
	::# trailing backslash
	%dk_call% dk_assertPath C:\Program Files\Common Files\	&::Delimiter mismatch
	
	::### No Quotes w/ special characters  i.e. ( and )
	::# foward slashes
	::%dk_call% dk_assertPath C:/Program Files (x86)/Common Files		&::BAD
	::# trailing forwardslash
	::%dk_call% dk_assertPath C:/Program Files (x86)/Common Files/		&::BAD
	::# lower case
	::%dk_call% dk_assertPath c:/program files (x86)/common files		&::BAD
	::# UPPER CASE
	::%dk_call% dk_assertPath C:/PROGRAM FILES (X86)/COMMON FILES		&::BAD
	::# windows path
	::%dk_call% dk_assertPath C:\Program Files (x86)\Common Files		&::BAD
	::# trailing backslash
	::%dk_call% dk_assertPath C:\Program Files (x86)\Common Files\		&::BAD
	
	set "myPath=C:/Program Files/Common Files"
	::# as Variable quoted
	%dk_call% dk_assertPath "%myPath%"								&::OK		
	::# As a variable using !_! quoted
	%dk_call% dk_assertPath "!myPath!"								&::OK
	::# As a variable name
    %dk_call% dk_assertPath myPath									&::OK
	::# As a variable name quoted
    %dk_call% dk_assertPath "myPath"								&::OK
	::# As a variable without quotes
	%dk_call% dk_assertPath %myPath%								&::OK	
	::# As a variable using !_! without quotes
	%dk_call% dk_assertPath !myPath!								&::OK
	
	set "myPath=C:/Program Files (x86)/Common Files"
	::# As a quoted variable name
    %dk_call% dk_assertPath "myPath"								&::OK
	::# as a ariable using %'s quoted
	%dk_call% dk_assertPath "%myPath%"								&::OK		
	::# As a variable using !'s quoted
	%dk_call% dk_assertPath "!myPath!"								&::OK
	::# As a variable name unquoted
    %dk_call% dk_assertPath myPath									&::OK
	::# as a variable using %'s unquoted
	::%dk_call% dk_assertPath %myPath%								&::BAD	
	::# As a variable using !'s unquoted
	::%dk_call% dk_assertPath !myPath!								&::BAD
	
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
	::%dk_call% dk_assertPath C:/NonExistent (x86)/Common Files	&::BAD
    
	::# as Variable
    set "myPath=C:/ProgramFiles (x86)/Common Files"
	::# As a quoted variable name to nonexistent path w/ special characters
    %dk_call% dk_assertPath "myPath"								&::ASSERT
	::# As a quoted variable using %'s to nonexistent path w/ special characters
    %dk_call% dk_assertPath "%myPath%"								&::ASSERT		
	::# As a quoted variable using !'s to nonexistent path w/ special characters
    %dk_call% dk_assertPath "!myPath!"								&::ASSERT
	::# As an unquoted variable name to nonexistent path w/ special characters
    %dk_call% dk_assertPath myPath									&::ASSERT
	::# As an unquoted variable using %'s to nonexistent path w/ special characters
	::%dk_call% dk_assertPath %myPath%								&::BAD
	::# As an unquoted variable using !'s to nonexistent path w/ special characters
    ::%dk_call% dk_assertPath !myPath!								&::BAD
%endfunction%

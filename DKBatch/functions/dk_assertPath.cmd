@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_assertPath(path)
::#
:dk_assertPath
setlocal enableDelayedExpansion
	echo dk_assertPath %*
	%dk_call% dk_debugFunc 0 99
	
	
	
	::### https://stackoverflow.com/a/16018942 ###
	::### https://www.robvanderwoude.com/escapechars.php ###
	::	%	%%	 
	::	^	^^	May not always be required in doublequoted strings, but it won't hurt
	::	&	^&
	::	<	^<
	::	>	^>
	::	|	^|
	::	'	^'	Required only in the FOR /F "subject" (i.e. between the parenthesis), unless backq is used
	::	`	^`	Required only in the FOR /F "subject" (i.e. between the parenthesis), if backq is used
	::	!	^^!	Required only when delayed variable expansion is active
	::	"	""	Required only inside the search pattern of FIND
	
	:: ### Required only in the FOR /F "subject" (i.e. between the parenthesis), even in doublequoted strings
	::	,	^,	
	::	;	^;
	::	=	^=
	::	(	^(
	::	)	^)
	
	::### Required only inside the regex pattern of FINDSTR
	::	\	\\	
	::	[	\[
	::	]	\]
	::	"	\"
	::	.	\.
	::	*	\*
	::	?

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
	:: percent
	:: equal
	:: multiply

	if defined %var% (
		echo      var = %var%
		set value="!%var:"=%!"
	)
	echo value = %value%
	
	for %%Z in (%value%) do (set _real_="%%~fZ")
	if not [%value:\=/%]==[%_real_:\=/%] (
		echo %red%value = %value:\=/%
		echo _real_ = %_real_:\=/%
		%dk_call% dk_echo "ASSERTION: dk_assertPath path:'%value:"=%' case mismatch%clr%"
		%return%
	)
	
::	if exist "%value:"=%"	(exit /b 0)

::	set "var=%value:)=%"
::	if defined %var:"=%	(set "value=!%var:"=%!")
	if exist "%value:"=%"	(exit /b 0)
	
    %dk_call% dk_error "ASSERTION: dk_assertPath path:'%value:"=%' not found!"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	::###### THES SHOULD ALL BE FOUND ######
	::# correct path
	%dk_call% dk_assertPath "C:\Program Files (x86)\Common Files"	&::OK
	::# foward slashes
	%dk_call% dk_assertPath "C:/Program Files (x86)/Common Files"	&::OK
	::# lower case
	%dk_call% dk_assertPath "c:/program files (x86)/common files"	&::OK
	::# UPPER CASE
	%dk_call% dk_assertPath "C:/PROGRAM FILES (x86)/COMMON FILES"	&::OK
	::# trailing slash
	%dk_call% dk_assertPath "C:\Program Files (x86)\Common Files\"	&::OK
	::# No quotes
	::%dk_call% dk_assertPath C:\Program Files\Common Files	&::BAD
	
	set "myPath=C:\Program Files (x86)\Common Files"
	::# as Variable
	%dk_call% dk_assertPath "%myPath%"								&::OK		
	::# As a variable using !_!
	%dk_call% dk_assertPath "!myPath!"								&::OK
	::# As a variable name
    %dk_call% dk_assertPath myPath									&::OK
	::# As a variable name quoted
    %dk_call% dk_assertPath "myPath"								&::OK
	::# CMD.exe
	%dk_call% dk_assertPath "%COMSPEC%"								&::OK
	::# As a variable without quotes
	::%dk_call% dk_assertPath %myPath%								&::BAD	
	::# As a variable using !_! without quotes
	::%dk_call% dk_assertPath !myPath!								&::BAD
	
	::###### THESE SHOULD ALL BE (NOT FOUND) ######
    %dk_call% dk_assertPath "C:/NonExistentPath"					&::ASSERT
		::# correct path
	%dk_call% dk_assertPath "C:\ProgramFiles (x86)\Common Files"	&::ASSERT
	::# foward slashes
	%dk_call% dk_assertPath "C:/ProgramFiles (x86)/Common Files"	&::ASSERT
	::# lower case
	%dk_call% dk_assertPath "c:/programfiles (x86)/common files"	&::ASSERT
	::# UPPER CASE
	%dk_call% dk_assertPath "C:/PROGRAMFILES (x86)/COMMON FILES"	&::ASSERT
	::# No quotes
	::%dk_call% dk_assertPath C:/PROGRAMFILES (x86)/COMMON FILES	&::BAD
    
	::# as Variable
    set "myPath=C:\ProgramFiles (x86)\Common Files"
	::# As a variable with %_%
    %dk_call% dk_assertPath "%myPath%"								&::ASSERT		
	::# As a variable with %_% without quotes
	::%dk_call% dk_assertPath %myPath%								&::BAD		
	::# As a variable with !_!
    %dk_call% dk_assertPath "!myPath!"								&::ASSERT
	::# As a variable with !_! without quotes
    ::%dk_call% dk_assertPath !myPath!								&::BAD
	::# As a variable name
    %dk_call% dk_assertPath myPath									&::ASSERT
	::# As a variable name quoted
    %dk_call% dk_assertPath "myPath"								&::ASSERT
%endfunction%

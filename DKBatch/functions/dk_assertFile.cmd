@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ################################################################################
rem # dk_assertFile(path)
rem #
rem # Throw assertion if argument is NOT a valid, existing file
rem #
:dk_assertFile
  if NOT DEFINED dk_assertFile_FORWARD_SLASHES (set "dk_assertFile_FORWARD_SLASHES=1")
  if NOT DEFINED dk_assertFile_CASE_SENSITIVE (set "dk_assertFile_CASE_SENSITIVE=1")
%setlocal%

	rem ### var/val path from all arguments ###
	(set _val_=%*)
	(set _var_=%_val_%)
	(set _var_=%_var_:(=%)
	(set _var_=%_var_:)=%)
	(set _var_=%_var_:"=%)
	(set _var_=%_var_: =%)
	if defined %_var_% (set _val_="!%_var_:"=%!") else (set "_var_=path")
	set _val_="%_val_:"=%"
	
	for %%Z in ("%_val_:"=%") do (set _real_="%%~fZ")

	if defined dk_assertFile_FORWARD_SLASHES set "_real_=%_real_:\=/%"

	rem ### Test case sensitive ###
	if defined dk_assertFile_CASE_SENSITIVE if NOT [%_val_%]==[%_real_%] (
		echo %red% %_var_%:'%_val_%' _real_:'%_real_%' mismatch %clr%
		%dk_call% dk_error "ASSERTION: dk_assertFile path:'%_val_:"=%' mismatch"
		%return%
	)

	rem ### Test path exists ###
	if NOT EXIST "%_val_:"=%" (
		%dk_call% dk_error "ASSERTION: dk_assertFile %_var_%:'%_val_:"=%' NOT found"
		%return%
	)
	
	rem ### Test path is NOT a dirctory
	if EXIST "%~1/*" (
		%dk_call% dk_error "ASSERTION: dk_assertFile %_var_%:'%_val_:"=%' is NOT a file"
		%return%
	)

	rem %dk_call% dk_debug "dk_assertFile %_var_% = %_val_%"
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem ###### THESE SHOULD ALL BE FOUND ######

	rem ### Quoted ###
	%dk_call% dk_assertFile "%SystemDrive%/"		&rem OK
	rem # existing path w/ foward slashes
	%dk_call% dk_assertFile "%SystemDrive%/Program Files/Common Files"		&rem OK
	rem # existing path w/ trailing forwardslash
	%dk_call% dk_assertFile "%SystemDrive%/Program Files/Common Files/"	&rem OK
	rem # existing lower case path
	%dk_call% dk_assertFile "%SystemDrive%/program files/common files"		&rem Case mismatch
	rem # existing UPPER CASE path
	%dk_call% dk_assertFile "%SystemDrive%/PROGRAM FILES/COMMON FILES"		&rem Case mismatch
	rem # windows path
	%dk_call% dk_assertFile "%SystemDrive%\Program Files\Common Files"		&rem Delimiter mismatch
	rem # existing path w/ trailing backslash
	%dk_call% dk_assertFile "%SystemDrive%\Program Files\Common Files\"	&rem Delimiter mismatch
	rem # existing path w/ mixed slashes
	%dk_call% dk_assertFile "%SystemDrive%/Program Files\Common Files"		&rem Delimiter mismatch
	rem # existing path w/ double forwardslashes
	%dk_call% dk_assertFile "%SystemDrive%//Program Files//Common Files"	&rem Delimiter mismatch
	rem # existing path w/ double backslashes
	%dk_call% dk_assertFile "%SystemDrive%\\Program Files\\Common Files"	&rem Delimiter mismatch

	rem ### Quoted w/ special characters  i.e. ( and )
	rem # foward slashes w/ special characters
	%dk_call% dk_assertFile "%SystemDrive%/Program Files (x86)/Common Files"	&rem OK
	rem # trailing forwardslash w/ special characters
	%dk_call% dk_assertFile "%SystemDrive%/Program Files (x86)/Common Files/"	&rem OK
	rem # lower case w/ special characters
	%dk_call% dk_assertFile "%SystemDrive%/program files (x86)/common files"	&rem Case mismatch
	rem # UPPER CASE w/ special characters
	%dk_call% dk_assertFile "%SystemDrive%/PROGRAM FILES (X86)/COMMON FILES"	&rem Case mismatch
	rem # windows path w/ special characters
	%dk_call% dk_assertFile "%SystemDrive%\Program Files (x86)\Common Files"	&rem Delimiter mismatch
	rem # trailing backslash w/ special characters
	%dk_call% dk_assertFile "%SystemDrive%\Program Files (x86)\Common Files\"	&rem Delimiter mismatch
	rem # existing path w/ mixed slashes
	%dk_call% dk_assertFile "%SystemDrive%/Program Files (x86)\Common Files"	&rem Delimiter mismatch
	rem # existing path w/ double forwardslashes
	%dk_call% dk_assertFile "%SystemDrive%//Program Files (x86)//Common Files"	&rem Delimiter mismatch
	rem # existing path w/ double backslashes
	%dk_call% dk_assertFile "%SystemDrive%\\Program Files (x86)\\Common Files"	&rem Delimiter mismatch

	rem ### Unquotes ###
	rem # foward slashes
	%dk_call% dk_assertFile %SystemDrive%/Program Files/Common Files		&rem OK
	rem # trailing forwardslash
	%dk_call% dk_assertFile %SystemDrive%/Program Files/Common Files/		&rem OK
	rem # lower case
	%dk_call% dk_assertFile %SystemDrive%/program files/common files		&rem Case mismatch
	rem # UPPER CASE
	%dk_call% dk_assertFile %SystemDrive%/PROGRAM FILES/COMMON FILES		&rem Case mismatch
	rem # windows path
	%dk_call% dk_assertFile %SystemDrive%\Program Files\Common Files		&rem Delimiter mismatch
	rem # trailing backslash
	%dk_call% dk_assertFile %SystemDrive%\Program Files\Common Files\		&rem Delimiter mismatch
	rem # existing path w/ mixed slashes
	%dk_call% dk_assertFile %SystemDrive%/Program Files\Common Files		&rem Delimiter mismatch
	rem # existing path w/ double forwardslashes
	%dk_call% dk_assertFile %SystemDrive%//Program Files//Common Files		&rem Delimiter mismatch
	rem # existing path w/ double backslashes
	%dk_call% dk_assertFile %SystemDrive%\\Program Files\\Common Files		&rem Delimiter mismatch

	rem ### as variable ###
	set "myPath=%SystemDrive%/Program Files/Common Files"
	rem # As a variable name
	%dk_call% dk_assertFile myPath									&rem OK
	rem # As a variable name quoted
	%dk_call% dk_assertFile "myPath"								&rem OK
	rem # as Variable quoted
	%dk_call% dk_assertFile "%myPath%"								&rem OK
	rem # As a variable using !_! quoted
	%dk_call% dk_assertFile "!myPath!"								&rem OK
	rem # As a variable without quotes
	%dk_call% dk_assertFile %myPath%								&rem OK
	rem # As a variable using !_! without quotes
	%dk_call% dk_assertFile !myPath!								&rem OK

	rem ### as variable w/ special characters  i.e. ( and ) ###
	set "myPath=%SystemDrive%/Program Files (x86)/Common Files"
	rem # As a variable name
	%dk_call% dk_assertFile myPath									&rem OK
	rem # As a quoted variable name
	%dk_call% dk_assertFile "myPath"								&rem OK
	rem # as a ariable using %'s quoted
	%dk_call% dk_assertFile "%myPath%"								&rem OK
	rem # As a variable using !'s quoted
	%dk_call% dk_assertFile "!myPath!"								&rem OK
	rem # As a variable without quotes
	rem %dk_call% dk_assertFile %myPath%								&rem CMD ERROR
	rem # As a variable using !_! without quotes
	rem %dk_call% dk_assertFile !myPath!								&rem CMD ERROR

	rem ### Unquotes w/ special characters  i.e. ( and )
	rem # foward slashes
	rem %dk_call% dk_assertFile %SystemDrive%/Program Files (x86)/Common Files		&rem CMD ERROR
	rem # trailing forwardslash
	rem %dk_call% dk_assertFile %SystemDrive%/Program Files (x86)/Common Files/		&rem CMD ERROR
	rem # lower case
	rem %dk_call% dk_assertFile %SystemDrive%/program files (x86)/common files		&rem CMD ERROR
	rem # UPPER CASE
	rem %dk_call% dk_assertFile %SystemDrive%/PROGRAM FILES (X86)/COMMON FILES		&rem CMD ERROR
	rem # windows path
	rem %dk_call% dk_assertFile %SystemDrive%\Program Files (x86)\Common Files		&rem CMD ERROR
	rem # trailing backslash
	rem %dk_call% dk_assertFile %SystemDrive%\Program Files (x86)\Common Files\		&rem CMD ERROR
	
	rem ###### THESE SHOULD ALL BE (NOT FOUND) ######
	rem # nonexistent path
	%dk_call% dk_assertFile "%SystemDrive%/NonExistent (x86)/Common Files"	&rem ASSERT
	rem # nonexistent lower case path
	%dk_call% dk_assertFile "%SystemDrive%/NonExistent (x86)/common files"	&rem ASSERT
	rem # nonexistent UPPER CASE path
	%dk_call% dk_assertFile "%SystemDrive%/NonExistent (x86)/COMMON FILES"	&rem ASSERT
	rem # nonexistent windows path
	%dk_call% dk_assertFile "%SystemDrive%\NonExistent (x86)\Common Files"	&rem ASSERT
	rem # nonexistent No quotes path
	rem %dk_call% dk_assertFile %SystemDrive%/NonExistent (x86)/Common Files	&rem CMD ERROR

%endfunction%

@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_fileReplaceLine(<file> <linenum> <newstring>)
::#
::#
:dk_fileReplaceLine
setlocal DisableDelayedExpansion

	set "file=%~1"
	set "linenum=%~2"
	set "newstring=%~3"

	<"%file%" >"%file%.tmp~" (
	  for /f "delims=" %%i in ('type "%file%"^|findstr /n "^"') do (
		set "line=%%i"
		setlocal EnableDelayedExpansion
		for /f "delims=:" %%j in ("!line!") do if %%j equ %linenum% (
		  echo(!newstring!
		) else (
		  echo(!line:*:=!
		)
		endlocal
	  )
	)
	move /y "%file%.tmp~" "%file%"
%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
 
	set "file=dk_fileReplaceLine_TEST.txt"
	echo one> %file%
	echo two>> %file%
	echo three>> %file%
	echo four>> %file%
	echo five>> %file%
	%dk_call% dk_fileReplaceLine "%file%" 3 "this line was replaced"
%endfunction%


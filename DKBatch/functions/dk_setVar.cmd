@echo off
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)



::####################################################################
::# dk_setVar()
::#
::#  Search the own batch file for <searchName> in a line with "call dk_setVar "
::#
:dk_setVar <var> <value>
	setLocal DisableDelayedExpansion
	::echo dk_setVar "%~1" = "%~2"
	
	for /f "usebackq tokens=* delims=" %%G in (`findstr /c:" dk_setVar %~1 " "%~f0"`) do (
		set "str=%%G"
	)
	
	SetLocal EnableDelayedExpansion	
	set "str=!str:	%dk_call%=%dk_call%!"
	set "str=!str: %dk_call%=%dk_call%!"
	set "str=!str:%dk_call% dk_setVar %~1 =!"
	::set "str=!str:*#=!"
	for /F "delims=" %%A in ("!str!") DO (
	  endlocal
	  endlocal
	  set "%~1=%%A"
	  %return%
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_setVar VAR "' ` ( ) ! \ / [ ] . ^ , ; = ? | < > & * ~ @ $ % ^ { } - _ "
	echo VAR = '%VAR%'
%endfunction%
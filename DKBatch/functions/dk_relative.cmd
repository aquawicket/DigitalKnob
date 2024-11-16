@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_relative(absolute_path base_directory rtn_var)
::#
::#		TODO:   reference the link below
::#    https://www.stevebreese.com/Relative-Path-Calculator
::#
:dk_relative
    call dk_debugFunc 3
 setlocal
 
	set src=%~1
	if defined %1 set src=!%~1!
	set bas=%~2
	if not defined bas set bas=%cd%
	for /f "tokens=*" %%a in ("%src%") do set src=%%~fa
	for /f "tokens=*" %%a in ("%bas%") do set bas=%%~fa
	set mat=&rem variable to store matching part of the name
	set upp=&rem variable to reference a parent
	for /f "tokens=*" %%a in ('echo.%bas:\=^&echo.%') do (
		set sub=!sub!%%a\
		call set tmp=%%src:!sub!=%%
		if "!tmp!" NEQ "!src!" (set mat=!sub!)else (set upp=!upp!..\)
	)
	set src=%upp%!src:%mat%=!
	( endlocal & REM RETURN VALUES
		if "%3" neq "" (set %~3=%src%) else echo %src%
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
	set "get_path=C:\Users\Administrator\digitalknob\file.txt"
	set "from_path=C:\Users\Administrator\digitalknob\DKBatch\functions"
	
	%dk_call% dk_echo "get relative path to: %get_path%"
	%dk_call% dk_echo "       starting from: %from_path%"
	
	%dk_call% dk_relative "%get_path%" "%from_path%" relative_path
	
	%dk_call% dk_echo "       relative_path: %relative_path%"

%endfunction%

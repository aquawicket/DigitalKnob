@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_consoleColumns()
::#
::#
:dk_consoleColumns
%setlocal%
 	%dk_call% dk_debugFunc 0 

	rem ###### SET ######
	if "%~1" neq "" (
		mode con cols=%~1
		set /a "dk_consoleColumns=%~1"

	rem ###### GET ######
	) else (
		for /f "tokens=1,2,3,4,5,6,7,8,9 delims=, " %%G in (
			'mode con^|findstr /C:Columns:'
		) do (
			set /a "dk_consoleColumns=%%H"
		)
	)
		
	endlocal & (
		set "dk_consoleColumns=%dk_consoleColumns%"
	)
%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0 

	%dk_call% dk_consoleColumns
	%dk_call% dk_echo "dk_consoleColumns = %dk_consoleColumns%"
	
	%dk_call% dk_echo "Resizing the width of the console +5 columns"
	%dk_call% dk_sleep 3
	set /a "Columns=%dk_consoleColumns%+5
	%dk_call% dk_consoleColumns %Columns%
	%dk_call% dk_echo "dk_consoleColumns = %dk_consoleColumns%"

%endfunction%


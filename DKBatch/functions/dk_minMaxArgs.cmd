@echo off
::if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_minMaxArgs(min, max)
::#
:dk_minMaxArgs
 setlocal
	::echo "%__FUNCTION__%(%__ARGS__%)"
	if %__ARGC__% lss %~1 %dk_call% dk_error "%__FUNCTION__%(%__ARGS__%): not enough arguments. Minimum is %~1, got %__ARGC__%"
	if "%~2" == "" if %__ARGC__% gtr %~1 %dk_call% dk_error "%__FUNCTION__%(%__ARGS__%): too many arguments. Maximum is %~1, got %__ARGC__%"
	if not "%~2" == "" if %__ARGC__% gtr %~2 %dk_call% dk_error "%__FUNCTION__%(%__ARGS__%): too many arguments. Maximum is %~2, got %__ARGC__%"
goto:eof

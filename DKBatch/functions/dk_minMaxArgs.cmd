@echo off
::call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_minMaxArgs(min, max)
::#
:dk_minMaxArgs
	echo "%__FUNCTION__%(%__ARGS__%)"
	if %__ARGC__% lss %~1 call dk_error "%__FUNCTION__%(%__ARGS__%): not enough arguments. Minimum is %~1, got %__ARGC__%"
	if "%~2" == "" if %__ARGC__% gtr %~1 call dk_error "%__FUNCTION__%(%__ARGS__%): too many arguments. Maximum is %~1, got %__ARGC__%"
	if not "%~2" == "" if %__ARGC__% gtr %~2 call dk_error "%__FUNCTION__%(%__ARGS__%): too many arguments. Maximum is %~2, got %__ARGC__%"
goto:eof

@echo off
call DK

::#################################################################################
::# dk_registryGetKey() <reg_path> <key> rtn_var
::#
::#
:dk_registryGetKey <reg_path> <key> rtn_var
	call dk_debugFunc
	if %__ARGC__% neq 3 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")

	FOR /F "tokens=2* skip=2" %%a in ('reg query "%1" /v "%2"') do ( 
		endlocal & call dk_set %3 "%%b" 
	)
goto:eof




:DKTEST ########################################################################

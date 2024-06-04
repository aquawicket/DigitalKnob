@echo off
call DK

::#################################################################################
::# dk_registryGetKey() <reg_path> <key> <result>
::#
::#
:dk_registryGetKey <reg_path> <key> <result>
	call dk_debugFunc
	if %__ARGC__% neq 3 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")

	FOR /F "tokens=2* skip=2" %%a in ('reg query "%1" /v "%2"') do ( 
		endlocal & set "%3=%%b" 
	)
goto:eof




:DKTEST ########################################################################

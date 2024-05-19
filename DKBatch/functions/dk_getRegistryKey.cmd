@echo off
call DK

::#################################################################################
::# dk_getRegistryKey() <reg_path> <key> <result>
::#
::#
:dk_getRegistryKey <reg_path> <key> <result>
	call dk_debugFunc
	if %__ARGC__% NEQ 3 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")

	FOR /F "tokens=2* skip=2" %%a in ('reg query "%1" /v "%2"') do ( 
		endlocal & set "%3=%%b" 
	)
goto:eof




:DKTEST ########################################################################

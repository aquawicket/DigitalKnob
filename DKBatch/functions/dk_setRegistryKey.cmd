@echo off
call DK

::#################################################################################
:: dk_setRegistryKey() <reg_path> <key> <type> <value>
::
::
:dk_setRegistryKey <reg_path> <key> <type> <value>
	call dk_debugFunc
	if %__ARGC__% NEQ 4 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	"C:\Windows\System32\reg.exe" ADD %~1 /v %~2 /t %~3 /d "%~4"
goto:eof
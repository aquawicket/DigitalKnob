@echo off
call DK

::#################################################################################
:: dk_deleteRegistryKey(<reg_path> <keyname> <valuename>)
::
::	reference: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/reg-delete
::	syntax: reg delete <keyname> [{/v valuename | /ve | /va}] [/f]
:dk_deleteRegistryKey
	call dk_debugFunc
	::if %__ARGC__% LSS 1 (call dk_error "%__FUNCTION__%(): not enough arguments")
	
	"%SystemRoot%\System32\reg.exe" delete "%~1" /f
goto:eof
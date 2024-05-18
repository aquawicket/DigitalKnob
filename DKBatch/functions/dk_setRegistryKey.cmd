@echo off
call DK

::#################################################################################
:: dk_setRegistryKey() <reg_path> <key> <type> <value>
::
::
:dk_setRegistryKey
	call dk_debugFunc
	if %__ARGC__% LSS 3 (call dk_error "%__FUNCTION__%(): not enough arguments")
		
	if "%~1" equ " " call dk_error "%__FUNCTION__%(): argument 1 is invalid"
	echo 1 = '%~1'

	if "%~2" equ " " ( 
	    set "_key_=/ve"
	) else (
	    set "_key_=/v %~2"
	)
	echo _key_ = '%_key_%'
	
	if "%~3" equ " " (
	    set "_type_="
	) else (
	    set "_type_=/t %~3"
	)
	echo _type_ = '%_type_%'
	
	if "%~4" equ " " (
	    set "_value_="
	) else (
	    set "_value_=%~4"
	)
	echo _value_ = '%_value_%'

	::echo "%SystemRoot%\System32\reg.exe" ADD "%~1" "%_key_%" "%_type_%" "%_value_%"
	::"%SystemRoot%\System32\reg.exe" ADD "%~1" "%_key_%" "%_type_%" "%_value_%"
	echo "%SystemRoot%\System32\reg.exe" ADD "%~1" %_key_% %_type_% /d "%_value_%"
	"%SystemRoot%\System32\reg.exe" ADD "%~1" %_key_% %_type_% /d "%_value_%"
goto:eof
@echo off
call DK

::#################################################################################
:: dk_setRegistryKey() <reg_path> <key> <type> <value>
::
::
:dk_setRegistryKey
	call dk_debugFunc
	if %__ARGC__% lss 2 (call dk_error "%__FUNCTION__%(): not enough arguments")
	
	
::	echo 1 = "%~1"
::	echo 2 = "'%~2'"
::	echo 3 = "'%~3'"
::	echo 4 = "'%~4'"
::	echo 5 = "'%~5'"
::
::	if "%~1" equ " " call dk_error "%__FUNCTION__%(): argument 1 is invalid"
::
::	if %%__ARGC__% equ 1 (
::	   set "_key_=/ve"
::	   set "_type_="
::	   if "%~2" equ " " (
::	      set "_value_="
::	   ) else (
::	      set "_value_=%~2"
::	   )
::	)
::
::	if %%__ARGC__% equ 2 (
::	   if "%~2" equ " " ( 
::	     set "_key_=/ve"
::	   ) else (
::	     set "_key_=/v %~2"
::	   )
::	   set "_type_="
::	   if "%~3" equ " " (
::	      set "_value_="
::	   ) else (
::	      set "_value_=%~3"
::	   )
::	)
::
::	if %%__ARGC__% equ 3 (
::	   if "%~2" equ " " ( 
::	      set "_key_=/ve"
::	   ) else (
::	      set "_key_=/v %~2"
::	   )
::	   if "%~3" equ " " ( 
::	     set "_type_="
::	   ) else (
::	     set "_type_=/t %3"
::	   )
::    	   set "_value_=%~4"
::	)

	if "%~1" equ "" call dk_error "%__FUNCTION__%(): argument 1 is invalid"
	::echo 1 = "%1"

	if "%~2" equ "" (set "_key_=/ve") else (set "_key_=/v %~2")
	::echo _key_ = '%_key_%'
	
	if "%~3" equ "" (set "_type_=") else (set "_type_=/t %~3")
	::echo _type_ = '%_type_%'
	
	if "%~4" equ "" (set "_value_=") else (set "_value_=%~4")
	::echo _value_ = '%_value_%'

	echo "%SystemRoot%\System32\reg.exe" ADD "%~1" %_key_% %_type_% /d "%_value_%" /f
	"%SystemRoot%\System32\reg.exe" ADD "%~1" %_key_% %_type_% /d "%_value_%" /f
goto:eof





:DKTEST ########################################################################

call dk_validate DKTOOLS_DIR "dk_getDKPaths"
call dk_set NOTEPADPP "%DKTOOLS_DIR%\%NOTEPADPP_FOLDER%"
call dk_set NOTEPADPP_EXE "%NOTEPADPP%notepad++.exe"
call dk_setRegistryKey "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++" "Icon" "REG_SZ" "\"%NOTEPADPP_EXE%\""
call dk_setRegistryKey "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++\command" " " " " "\"%NOTEPADPP_EXE%\" \"%%%%^1\""
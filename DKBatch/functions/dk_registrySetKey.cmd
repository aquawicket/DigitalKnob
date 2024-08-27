@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::#################################################################################
:: dk_registrySetKey() <reg_path> <key> <type> <value>
::
::
:dk_registrySetKey
 setlocal
	call dk_debugFunc 4
	
	if "%~1" equ "" %dk_call% dk_error "%__FUNCTION__%(): argument 1 is invalid"
	if "%~2" equ "" (set "_key_=/ve") else (set "_key_=/v %~2")
	if "%~3" equ "" (set "_type_=") else (set "_type_=/t %~3")
	if "%~4" equ "" (set "_value_=") else (set "_value_=%~4")

	echo "%SystemRoot%\System32\reg.exe" ADD "%~1" %_key_% %_type_% /d "%_value_%" /f
	"%SystemRoot%\System32\reg.exe" ADD "%~1" %_key_% %_type_% /d "%_value_%" /f
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_setDKTOOLS_DIR"
	%dk_call% dk_set NOTEPADPP_DIR "%DKTOOLS_DIR%\%NOTEPADPP_FOLDER%"
	%dk_call% dk_set NOTEPADPP_EXE "%NOTEPADPP_DIR%\notepad++.exe"
	%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++" "Icon" "REG_SZ" "\"%NOTEPADPP_EXE%\""
	%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++\command" " " " " "\"%NOTEPADPP_EXE%\" \"%%%%^1\""
goto:eof

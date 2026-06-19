@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ################################################################################
rem # dk_fileVariable(file varname [set])
rem #
rem #		Get or Set a variable to or from a file
rem #
:dk_fileVariable
rem echo %~nx0 %*
%setlocal%

	set "_file_=%~1"
	set "_file_=%_file_:/=\%"
	rem set "_varname_=%~2"
	rem set _set_=%~3
	
	rem for /f "tokens=2*" %%a in ("%*") do (set b=%%~b)
	if NOT EXIST "%_file_%" (>"%_file_%" echo >nul)
  
	rem ###### SET ######
	if [%3] neq [] ( 
		if "%~3" neq "" ( 
			rem (%dk_call% dk_fileContains "%_file_%" "%~2=" && %dk_call% dk_fileReplaceMatchLine "%_file_%" "%~2=" %~2=%b% || >>"%_file_%" echo.%~2=%b%)
			%dk_call% dk_fileContains "%_file_%" "%~2=" && (%dk_call% dk_fileReplaceMatchLine "%_file_%" "%~2=" "%~2=%~3") || (>>"%_file_%" echo.%~2=%~3)
		) else (
			%dk_call% dk_fileContains "%_file_%" "%~2=" && (%dk_call% dk_fileReplaceMatchLine "%_file_%" "%~2=" %~2=%~3)
		)
		set dk_fileVariable=%~3
	rem ###### GET ######
	) else (
		for /f "usebackq delims== tokens=1,2" %%A in ("%_file_%") do (
			if /i "%%~A" equ "%~2" (
				set dk_fileVariable=%%B
			)
		)
	)
	
	:return
	endlocal & (
		set %~2=%dk_fileVariable%
	)
%endfunction%




























rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_validate DKCACHE_DIR   %dk_call% dk_DKCACHE_DIR
	set "file=%DKCACHE_DIR:/=\%\dk_fileVariable_TEST.txt"
	%dk_call% dk_delete "%file%"
	
	rem ###### SET ######
	echo.
	echo.dk_fileVariable "%file%" one "a b c"
	%dk_call% dk_fileVariable "%file%" one "a b c" 
	if "%one%" equ "a b c" (%dk_call% dk_success "one = '%one%'") else (%dk_call% dk_error "one = '%one%'")
	echo.----------------- dk_fileVariable_TEST.txt ---------------------
	type "%file:/=\%"
	echo.----------------------------------------------------------------
	set "one="
	
	
	rem ###### SET ######
	echo.
	echo.dk_fileVariable "%file%" two "d e f" 123
	%dk_call% dk_fileVariable "%file%" two "d e f" 123
	if "%two%" equ "d e f" (%dk_call% dk_success "two = '%two%'") else (%dk_call% dk_error "two = '%two%'")
	echo.----------------- dk_fileVariable_TEST.txt ---------------------
	type "%file:/=\%"
	echo.----------------------------------------------------------------
	set "two="
	
	
	rem ###### SET ######
	echo.
	echo.dk_fileVariable "%file%" three "g h i"
	%dk_call% dk_fileVariable "%file%" three "g h i"
	if "%three%" equ "g h i" (%dk_call% dk_success "three = '%three%'") else (%dk_call% dk_error "three = '%three%'")
	echo.----------------- dk_fileVariable_TEST.txt ---------------------
	type "%file:/=\%"
	echo.----------------------------------------------------------------
	set "three="
	
	rem ###### GET ######
	echo.
	echo.dk_fileVariable "%file%" one
	%dk_call% dk_fileVariable "%file%" one
	if "%one%" equ "a b c" (%dk_call% dk_success "one = '%one%'") else (%dk_call% dk_error "one = '%one%'")
  echo.----------------- dk_fileVariable_TEST.txt ---------------------
	type "%file:/=\%"
	echo.----------------------------------------------------------------
	set "one="
	
	rem ###### GET ######
	echo.
	echo.dk_fileVariable "%file%" two
	%dk_call% dk_fileVariable "%file%" two
	if "%two%" equ "d e f" (%dk_call% dk_success "two = '%two%'") else (%dk_call% dk_error "two = '%two%'")
	echo.----------------- dk_fileVariable_TEST.txt ---------------------
	type "%file:/=\%"
	echo.----------------------------------------------------------------
	set "two="

	rem ###### GET ######
	echo.
	echo.dk_fileVariable "%file%" three
	%dk_call% dk_fileVariable "%file%" three
	if "%three%" equ "g h i" (%dk_call% dk_success "three = '%three%'") else (%dk_call% dk_error "three = '%three%'")
	echo.----------------- dk_fileVariable_TEST.txt ---------------------
	type "%file:/=\%"
	echo.----------------------------------------------------------------
  set "three="

	rem ###### SET ######
	echo.
	echo.dk_Variable "%file%" two "x y z"
	%dk_call% dk_fileVariable "%file%" two "x y z"
	if "%two%" equ "x y z" (%dk_call% dk_success "two = '%two%'") else (%dk_call% dk_error "two = '%two%'")
	echo.----------------- dk_fileVariable_TEST.txt ---------------------
	type "%file:/=\%"
	echo.----------------------------------------------------------------
	set "two="
	
	rem ###### GET ######
	echo.
	echo.dk_fileVariable "%file%" two
	%dk_call% dk_fileVariable "%file%" two
	if "%two%" equ "x y z" (%dk_call% dk_success "two = '%two%'") else (%dk_call% dk_error "two = '%two%'")
	echo.----------------- dk_fileVariable_TEST.txt ---------------------
	type "%file:/=\%"
	echo.----------------------------------------------------------------
	set "two="
	
	rem ###### SET ######
	echo.
	echo.dk_fileVariable "%file%" one " "
	%dk_call% dk_fileVariable "%file%" one " "
	if "%one%" equ " " (%dk_call% dk_success "one = '%one%'") else (%dk_call% dk_error "one = '%one%'")
	echo.----------------- dk_fileVariable_TEST.txt ---------------------
	type "%file:/=\%"
	echo.----------------------------------------------------------------
	set "one="
	
	rem ###### GET ######
	echo.
	echo.dk_fileVariable "%file%" one
	%dk_call% dk_fileVariable "%file%" one
	if "%one%" equ " " (%dk_call% dk_success "one = '%one%'") else (%dk_call% dk_error "one = '%one%'")
	echo.----------------- dk_fileVariable_TEST.txt ---------------------
	type "%file:/=\%"
	echo.----------------------------------------------------------------
	set "one="
	
	rem ###### SET ######
	echo.
	echo.dk_fileVariable "%file%" two ""
	%dk_call% dk_fileVariable "%file%" two ""
	if "%two%" equ "" (%dk_call% dk_success "two = '%two%'") else (%dk_call% dk_error "two = '%two%'")
	echo.----------------- dk_fileVariable_TEST.txt ---------------------
	type "%file:/=\%"
	echo.----------------------------------------------------------------
	set "two="
	
	rem ###### GET ######
	echo.
	echo.dk_fileVariable "%file%" two
	%dk_call% dk_fileVariable "%file%" two
	if "%two%" equ "" (%dk_call% dk_success "two = '%two%'") else (%dk_call% dk_error "two = '%two%'")
	echo.----------------- dk_fileVariable_TEST.txt ---------------------
	type "%file:/=\%"
	echo.----------------------------------------------------------------
	set "two="
	
	rem ###### SET ######
	echo.
	echo.dk_fileVariable "%file%" three null
	%dk_call% dk_fileVariable "%file%" three null
	if "%three%" equ "null" (%dk_call% dk_success "three = '%three%'") else (%dk_call% dk_error "three = '%three%'")
	echo.----------------- dk_fileVariable_TEST.txt ---------------------
	type "%file:/=\%"
	echo.----------------------------------------------------------------
	set "three="
	
	rem ###### GET ######
	echo.
	echo.dk_fileVariable "%file%" three
	%dk_call% dk_fileVariable "%file%" three
	if "%three%" equ "null" (%dk_call% dk_success "three = '%three%'") else (%dk_call% dk_error "three = '%three%'")
	echo.----------------- dk_fileVariable_TEST.txt ---------------------
	type "%file:/=\%"
	echo.----------------------------------------------------------------
	set "three="
	
	rem ###### GET ######
	echo.
	echo.dk_fileVariable "%file%" four
	%dk_call% dk_fileVariable "%file%" four
	if "%four%" equ "" (%dk_call% dk_success "four = '%four%'") else (%dk_call% dk_error "four = '%four%'")
	echo.----------------- dk_fileVariable_TEST.txt ---------------------
	type "%file:/=\%"
	echo.----------------------------------------------------------------
	set "four="
	
	rem %dk_call% dk_fileTrim "%file%"
%endfunction%

@echo off
if "%~1" equ "" (goto DKINSTALL)

:runDKCSharp
	set "COMPILER_EXE=%~1"
	if NOT defined COMPILER_EXE (echo ERROR: COMPILER_EXE is invalid)
	
	set "DKCSharp_FILE=%~2"
	if NOT defined DKCSharp_FILE (echo ERROR: DKCSharp_FILE is invalid)
	
	:: get the app name
	for %%Z in ("%DKCSharp_FILE%") do (set "APP=%%~nZ")
	
	::###### Compile Code ######
	echo compiling ...
	if EXIST "%APP%.exe" (del %APP%.exe)

	::%COMPILER_EXE% /nologo /out:%APP%.exe %DKCSharp_FILE%
	%COMPILER_EXE% /nologo /out:%APP%.exe %USERPROFILE%\Digital Knob\Development\DKCSharp\functions\DK.cs %DKCSharp_FILE%
	::%COMPILER_EXE% /nologo /out:%APP%.exe *.cs
	
	if NOT EXIST "%APP%.exe" (
		echo.
		echo ERROR: compilation of %DKCSharp_FILE% failed.
		pause
		goto:eof
	)
	
	::###### run executable ######
	cls
	title %DKCSharp_FILE%
	"%ComSpec%" /v:on /k "%APP%.exe" && (echo returned TRUE) || (echo returned FALSE)
	
	::###### exit_code ######
	if %ERRORLEVEL% neq 0 (
		echo ERROR:%ERRORLEVEL%
		pause
	)
%endfunction%

























:DKINSTALL
	if "%~1" neq "" (goto:eof)
	
	echo Installing DKCSharp . . .
	
	@echo off&rem ###### DK.cmd #########################################################################################################################
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/") 
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if not defined DKINIT_cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %* && exit /b %errorlevel%)
	rem #################################################################################################################################################
	
	::###### Install DKCSharp ######
	::###### COMPILER_EXE ######
	:: find csc.exe
	for /r "%SystemRoot:\=/%/Microsoft.NET/Framework/" %%# in ("*csc.exe") do  set "csc_exe=%%#"
	set "COMPILER_EXE=%csc_exe:\=/%"
	%dk_call% dk_assertPath COMPILER_EXE
	ftype DKCSharp="%ComSpec%" /V:ON /K call "%~f0" "%COMPILER_EXE%" "%%1" %%*
	assoc .cs=DKCSharp
	
	%dk_call% dk_success "DKCSharp install complete"
%endfunction%
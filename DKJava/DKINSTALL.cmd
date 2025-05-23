@echo off
if "%~1" equ "" (goto :DKINSTALL)

:runDKCSharp
	set "COMPILER_EXE=%~1"
	if not defined COMPILER_EXE (echo ERROR: COMPILER_EXE is invalid)
	
	set "DKJava_FILE=%~2"
	if not defined DKJava_FILE (echo ERROR: DKJava_FILE is invalid)
	
	:: get the app name
	for %%Z in ("%DKJava_FILE%") do (set "APP=%%~nZ")
	
	::###### Compile Code ######
	echo compiling ...
	if exist %APP%.exe (del %APP%.exe)

	::%COMPILER_EXE% /nologo /out:%APP%.exe  %DKJava_FILE%
	::%COMPILER_EXE% /nologo /out:%APP%.exe DK.cs %DKJava_FILE%
	%COMPILER_EXE% /nologo /out:%APP%.exe *.java
	
	if not exist "%APP%.exe" (
		echo:
		echo ERROR: compilation of %DKJava_FILE% failed.
		pause
		goto:eof
	)
	
	::###### run executable ######
	cls
	title %DKJava_FILE%
    %ComSpec% /v:on /k "%APP%.exe" && (echo returned TRUE) || (echo returned FALSE)
	
	::###### exit_code ######
	if %ERRORLEVEL% neq 0 (
		echo ERROR:%ERRORLEVEL%
		pause
	)
%endfunction%

























:DKINSTALL
	if "%~1" neq "" (goto:eof)
	
	echo Installing DKJava . . .
	
	::###### DK.cmd ######
	if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/")
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
	
	::###### Install DKCSharp ######
	::###### COMPILER_EXE ######
	:: find csc.exe
	for /r "%SystemRoot:\=/%/Microsoft.NET/Framework/" %%# in ("*csc.exe") do  set "CSC_EXE=%%#"
	set "COMPILER_EXE=%CSC_EXE%"
	%dk_call% dk_assertVar COMPILER_EXE
	ftype DKJava=%ComSpec% /V:ON /K call "%~f0" "%COMPILER_EXE%" "%%1" %%*
	assoc .java=DKJava
	
	%dk_call% dk_success "DKJava install complete"
%endfunction%
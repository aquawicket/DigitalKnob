@echo off
if "%~1" equ "" (goto :DKINSTALL)

:runDKCSharp
	set "COMPILER_EXE=%~1"
	if NOT defined COMPILER_EXE (echo ERROR: COMPILER_EXE is invalid)
	
	set "DKJava_FILE=%~2"
	if NOT defined DKJava_FILE (echo ERROR: DKJava_FILE is invalid)
	
	:: get the app name
	for %%Z in ("%DKJava_FILE%") do (set "APP=%%~nZ")
	
	::###### Compile Code ######
	echo compiling ...
	if EXIST "%APP%.exe" (del %APP%.exe)

	%COMPILER_EXE% %DKJava_FILE%
	
	if NOT EXIST "%APP%.java" (
		echo(
		echo ERROR: compilation of %DKJava_FILE% failed.
		pause
		goto:eof
	)
	
	::###### run executable ######
	cls
	title %DKJava_FILE%
	set "JAVA_EXE=%COMPILER_EXE:javac=java%"
	
    %JAVA_EXE:/=\% %APP% &:: && (echo returned TRUE) || (echo returned FALSE)
	::echo C:\Users\Administrator\DigitalKnob\Development\3rdParty\openjdk-11_windows-x64_bin\bin\java.exe %APP%
	
	::###### exit_code ######
	if %ERRORLEVEL% neq 0 (
		echo ERROR:%ERRORLEVEL%
		pause
	)
%endfunction%

























:DKINSTALL
	if "%~1" neq "" (goto:eof)
	
	echo Installing DKJava . . .
	
	@echo off&::###### DK.cmd #########################################################################################################################
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/") 
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
	::#################################################################################################################################################
	
	::###### Install Java ######
	%dk_call% dk_depend openjdk
	%dk_call% dk_assertPath "%JAVAC_EXE%"
	
	::###### COMPILER_EXE ######
	set "COMPILER_EXE=%JAVAC_EXE%"
	%dk_call% dk_assertPath "%COMPILER_EXE%"
	ftype DKJava=%ComSpec% /V:ON /K call "%~f0" "%COMPILER_EXE%" "%%1" %%*
	assoc .java=DKJava
	
	%dk_call% dk_success "DKJava install complete"
%endfunction%
@echo off
if "%~1" equ "" (goto :DKINSTALL)

:runDKCSharp
	set "COMPILER_EXE=%~1"
	if NOT defined COMPILER_EXE (echo ERROR: COMPILER_EXE is invalid)
	
	set "DKJava_FILE=%~2"
	if NOT defined DKJava_FILE (echo ERROR: DKJava_FILE is invalid)
	
	rem get the app name
	for %%Z in ("%DKJava_FILE%") do (set "APP=%%~nZ")
	
	::###### Compile Code ######
	echo compiling ...
	if EXIST "%APP%.exe" (del %APP%.exe)

	%COMPILER_EXE% %DKJava_FILE%
	
	if NOT EXIST "%APP%.java" (
		echo.
		echo ERROR: compilation of %DKJava_FILE% failed.
		pause
		goto:eof
	)
	
	::###### run executable ######
	cls
	title %DKJava_FILE%
	set "java_exe=%COMPILER_EXE:javac=java%"
	
    %java_exe:/=\% %APP% &rem  && (echo returned TRUE) || (echo returned FALSE)
	::echo C:/Users/Administrator/Digital Knob/Development/3rdParty/openjdk-11_windows-x64_bin/bin/java.exe %APP%
	
	::###### exit_code ######
	if %ERRORLEVEL% neq 0 (
		echo ERROR:%ERRORLEVEL%
		pause
	)
%endfunction%

























:DKINSTALL
	if "%~1" neq "" (goto:eof)
	
	echo Installing DKJava . . .
	
	rem shebang
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
	
	::###### Install Java ######
	%dk_call% dk_validate openjdk %dk_call% dk_depend openjdk
	%dk_call% dk_assertPath "%java_exe%"
	%dk_call% dk_assertPath "%javac_exe%"
	
	::"%java_exe%" -classpath %USERPROFILE%/Digital Knob/Development/DKJava/functions com.DigitalKnob.DKJava
	
	::###### COMPILER_EXE ######
	set "COMPILER_EXE=%javac_exe%"
	%dk_call% dk_assertPath "%COMPILER_EXE%"
	ftype DKJava=%ComSpec% /V:ON /K call "%~f0" "%COMPILER_EXE%" "%%1" %%*
	assoc .java=DKJava
	
	%dk_call% dk_success "DKJava install complete"
%endfunction%
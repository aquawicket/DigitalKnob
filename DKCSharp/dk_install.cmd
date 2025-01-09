@echo off
if "%~1" == "" (goto dk_install)

:runDKCSharp
	set "COMPILER_EXE=%~1"
	if not defined COMPILER_EXE    echo ERROR: COMPILER_EXE is invalid
	
	set "DKCSharp_FILE=%~2"
	if not defined DKCSharp_FILE    echo ERROR: DKCSharp_FILE is invalid
	
	:: get the app name
	for %%Z in ("%DKCSharp_FILE%") do set "APP=%%~nZ"	
	
	::###### Compile Code ######
	echo compiling ...
	if exist %APP%.exe  del %APP%.exe

	::%COMPILER_EXE% /nologo /out:%APP%.exe  %DKCSharp_FILE%
	%COMPILER_EXE% /nologo /out:%APP%.exe DK.cs %DKCSharp_FILE%
	::%COMPILER_EXE% /nologo /out:%APP%.exe *.cs
	
	if not exist "%APP%.exe" (
		echo: 
		echo ERROR: compilation of %DKCSharp_FILE% failed.
		pause
		goto:eof
	)
	
	::###### run executable ######
	cls
	title %DKCSharp_FILE%
    %COMSPEC% /v:on /k "%APP%.exe" && (echo returned TRUE) || (echo returned FALSE)
	
	::###### exit_code ######
	if %ERRORLEVEL% neq 0 echo ERROR:%ERRORLEVEL% && pause
	
	::###### reload ######
::	if not exist %~dp0\reload goto:eof
::	del %~dp0\reload
::	cls
::	goto runDKCSharp
%endfunction%

























:dk_install
	::###### DKINIT ######
	if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
	if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
	
	::###### Install DKCSharp ######
	%dk_call% dk_echo "Installing DKCSharp . . ."
	
	::###### COMPILER_EXE ######
	:: find csc.exe
	set "csc="
	for /r "%SystemRoot%\Microsoft.NET\Framework\" %%# in ("*csc.exe") do  set "CSC_EXE=%%#"
	set "COMPILER_EXE=%CSC_EXE%"
	%dk_call% dk_assertVar COMPILER_EXE
	%dk_call% dk_printVar COMPILER_EXE

	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKCSharp"
	ftype DKCSharp=%COMSPEC% /c call "%~f0" "%COMPILER_EXE%" "%%1" %%*
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.cs"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cs"
	assoc .cs=DKCSharp
	
	%dk_call% dk_success "DKCSharp install complete"
%endfunction%
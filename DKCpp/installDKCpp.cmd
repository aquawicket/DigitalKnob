@echo off

if "%~1" neq "" goto:runDKCpp
:installDKCpp
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	::###### Install DKCpp ######
	call dk_echo "Installing DKCpp . . ."
	call dk_validate DKBATCH_FUNCTIONS_DIR "call dk_validateBranch"
	
	set "MSYSTEM=CLANG64"
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate GXX_EXE "call %DKIMPORTS_DIR%\gcc\dk_installGcc.cmd"
	
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKCpp"
	ftype DKCpp=cmd /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%GXX_EXE%" "%%1" %%*
	
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\.cpp"
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cpp
	assoc .cpp=DKCpp
	
	call dk_echo "DKCpp install complete"
goto:eof



:runDKCpp
	::set "DKBATCH_FUNCTIONS_DIR=%~1"
	::set "DKBATCH_FUNCTIONS_DIR_=%~1\"
	set "GXX_EXE=%~2"
	set "DKCPP_FILE=%~3"
	
	echo compiling ...
	del temp.exe
	%GXX_EXE% -DDKTEST=1 -o temp -static "%DKCPP_FILE%"
	
	if not exist "temp.exe" (
		echo: 
		echo ERROR: compilation of %DKCPP_FILE% failed.
		pause
		goto:eof
	)
	
	title %DKCPP_FILE%
	cls
    cmd /v:on /k "temp.exe" && echo success: return value: !errorLevel! || echo failed: return value: !errorLevel!
goto:eof
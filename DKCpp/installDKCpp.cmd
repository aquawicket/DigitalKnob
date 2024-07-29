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
	
	
	ftype DKCpp=cmd /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%GXX_EXE%" "%%1" %%*
	assoc .cpp=DKCpp
	::call dk_registrySetKey "HKEY_CLASSES_ROOT\DKCpp\DefaultIcon" "" "REG_SZ" "C:\Windows\System32\cmd.exe"
	
	call dk_echo "DKCpp install complete"
	call dk_pause
goto:eof



:runDKCpp
	set "DKBATCH_FUNCTIONS_DIR=%~1"
	set "DKBATCH_FUNCTIONS_DIR_=%~1\"
	set "GXX_EXE=%~2"
	set "DKCPP_FILE=%~3"
	
	echo compiling ...
	%GXX_EXE% -o temp -static "%DKCPP_FILE%"
	cls
	cmd /c temp.exe
goto:eof
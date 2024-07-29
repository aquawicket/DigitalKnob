@echo off

if "%~1" neq "" goto:runDKC
:installDKC
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	::###### Install DKC ######
	call dk_echo "Installing DKC . . ."
	call dk_validate DKBATCH_FUNCTIONS_DIR "call dk_validateBranch"
	
	set "MSYSTEM=CLANG64"
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate GCC_EXE "call %DKIMPORTS_DIR%\gcc\dk_installGcc.cmd"
	
	
	ftype DKC=cmd /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%GCC_EXE%" "%%1" %%*
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\.c"
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.c"
	assoc .c=DKC
	::call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.h"
	::assoc .h=DKC
	::call dk_registrySetKey "HKEY_CLASSES_ROOT\DKC\DefaultIcon" "" "REG_SZ" "C:\Windows\System32\cmd.exe"
	
	call dk_echo "DKC install complete"
goto:eof



:runDKC
	::set "DKBATCH_FUNCTIONS_DIR=%~1"
	::set "DKBATCH_FUNCTIONS_DIR_=%~1\"
	set "GCC_EXE=%~2"
	set "DKC_FILE=%~3"
	
	echo compiling ...
	del temp.exe
	%GCC_EXE% -DDKTEST=1 -o temp -static "%DKC_FILE%"
	
	if not exist "temp.exe" (
		echo: 
		echo ERROR: compilation of %DKC_FILE% failed.
		pause
		goto:eof
	)
	
	title %DKC_FILE%
	cls
    cmd /v:on /k "temp.exe" && echo success: return value: !errorLevel! || echo failed: return value: !errorLevel!
goto:eof
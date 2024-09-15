@echo off

if not "%~1" == "" (goto:runDKCMake)
:installDKCMake
	::###### DKINIT ######
	if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
	if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
	
	::###### Install DKBash ######
	%dk_call% dk_echo "Installing DKCmake . . ."
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmake"
	if not defined DKIMPORTS_DIR %dk_call% dk_validateBranch
	if not defined CMAKE_EXE call "%DKIMPORTS_DIR%\cmake\dk_installCmake"
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKCmake"
	ftype DKCmake=cmd /c call "%~f0" "%CMAKE_EXE%" "%DKCMAKE_FUNCTIONS_DIR%" "%%1" %*
	%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\DKCmake\DefaultIcon" "" "REG_SZ" "%CMAKE%\bin\cmake-gui.exe"
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.cmake"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmake"
	assoc .cmake=DKCmake

	%dk_call% dk_echo "DKCmake install complete"
%endfunction%


:runDKCMake
	set "CMAKE_EXE=%~1"
	set "DKCMAKE_FUNCTIONS_DIR=%~2"
	set "DKCMAKE_FUNCTIONS_DIR=%DKCMAKE_FUNCTIONS_DIR:\=/%"
	set "DKSCRIPT_PATH=%~3"
	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"
	
	
	::###### run script ######
    "%CMAKE_EXE%" -DQUEUE_BUILD=ON -DCLANG64=ON -DWIN_X86_64=ON -DEBUG=ON -DDKCMAKE_FUNCTIONS_DIR="%DKCMAKE_FUNCTIONS_DIR%" -P "%DKSCRIPT_PATH%"
	
	::###### exit_code ######
	if %ERRORLEVEL% neq 0 echo ERROR:%ERRORLEVEL% && pause
	
	::###### reload ######
	if not exist %~dp0\reload goto:eof
	del %~dp0\reload
	cls
	goto:runDKCMake
	
%endfunction%
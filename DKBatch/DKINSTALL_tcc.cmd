@echo off
if "%~1" equ "" (goto :DKINSTALL)

:runDKtcc
	echo:
	echo runDKtcc(%*)
	
	echo:
	if not exist "%DKBATCH_FUNCTIONS_DIR%"	(set "DKBATCH_FUNCTIONS_DIR=%~1")
	echo DKBATCH_FUNCTIONS_DIR = %DKBATCH_FUNCTIONS_DIR%
	::%dk_call% dk_assertPath "%DKBATCH_FUNCTIONS_DIR%"
	
	echo:
	if not exist "%DKBATCH_FUNCTIONS_DIR_%"	(set "DKBATCH_FUNCTIONS_DIR_=%~1/")
	echo DKBATCH_FUNCTIONS_DIR_ = %DKBATCH_FUNCTIONS_DIR_%
	::%dk_call% dk_assertPath "%DKBATCH_FUNCTIONS_DIR_%"
	
	echo:
	if not exist "%TCC_RT_EXE%"				(set "TCC_RT_EXE=%~2")
	echo TCC_RT_EXE = %TCC_RT_EXE%
	::%dk_call% dk_assertPath "%TCC_RT_EXE%"
	
	echo:
	if not exist "%DKSCRIPT_PATH%"			(set "DKSCRIPT_PATH=%~3")
	echo DKSCRIPT_PATH = %DKSCRIPT_PATH%
	::%dk_call% dk_assertPath "%DKSCRIPT_PATH%"
	
	echo:
	if not defined DKSCRIPT_ARGS			(for /F "usebackq tokens=4*" %%a in ('%*') do set DKSCRIPT_ARGS=%%b)
	echo DKSCRIPT_ARGS = %DKSCRIPT_ARGS%
	
	::###### run script ######
	:: "%TCC_RT_EXE%"	path to tcc.exe
	:: /V:ON		enable delayed expansion
	:: /K			keep the window open at the TCC prompt.
	echo:
	echo "%TCC_RT_EXE%" /V:ON /K call "%DKSCRIPT_PATH%"
	"%TCC_RT_EXE%" /V:ON /K call "%DKSCRIPT_PATH%"
	::"%TCC_RT_EXE%" /V:ON /K call "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%

	::###### exit_code ######
	if %ERRORLEVEL% neq 0 (
		echo exit_code:%ERRORLEVEL%
	)
	pause
%endfunction%
















:DKINSTALL
	if "%~1" neq "" (goto:eof)
	
	::#################################################### DigitalKnob DKBatch ########################################################################
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
	::#################################################################################################################################################
	
	::###### Install DKtcc ######
	%dk_call% dk_echo "Installing DKtcc . . ."
	%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_assertPath "%DKBATCH_FUNCTIONS_DIR%"
	%dk_call% dk_validate DKTOOLS_DIR 			"%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_assertPath "%DKTOOLS_DIR%"
	%dk_call% dk_validate DKIMPORTS_DIR 		"%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_assertPath "%DKIMPORTS_DIR%"
	%dk_call% dk_validate TCC_RT_EXE 			"%dk_call% %DKIMPORTS_DIR%/tcc-rt/DKINSTALL.cmd"
	%dk_call% dk_assertPath "%TCC_RT_EXE%"
	
	::%dk_call% dk_registryDeleteKey 	"HKCR\DKtcc"
	ftype DKtcc="%ComSpec%" /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%TCC_RT_EXE%" "%%1" %%*
	%dk_call% dk_registrySetKey 	"HKCR\DKtcc\DefaultIcon" "" "REG_SZ" "%TCC_RT_EXE%"
	::%dk_call% dk_registryDeleteKey 	"HKCR\.cmd"
	::%dk_call% dk_registryDeleteKey 	"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmd"
	assoc .cmd=DKtcc
	::assoc .tcc=DKtcc
	
	%dk_call% dk_success "DKtcc install complete"
%endfunction%




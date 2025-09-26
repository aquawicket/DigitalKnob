@echo off
if "%~1" equ "" (goto :DKINSTALL)

:runDKtcc
	echo(
	echo runDKtcc(%*)
	
	echo(
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR%"	(set "DKBATCH_FUNCTIONS_DIR=%~1")
	echo DKBATCH_FUNCTIONS_DIR = %DKBATCH_FUNCTIONS_DIR%
	::%dk_call% dk_assertPath "%DKBATCH_FUNCTIONS_DIR%"
	
	echo(
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%"	(set "DKBATCH_FUNCTIONS_DIR_=%~1/")
	echo DKBATCH_FUNCTIONS_DIR_ = %DKBATCH_FUNCTIONS_DIR_%
	::%dk_call% dk_assertPath "%DKBATCH_FUNCTIONS_DIR_%"
	
	echo(
	if NOT EXIST "%tcc-rt_exe%"				(set "tcc-rt_exe=%~2")
	echo tcc-rt_exe = %tcc-rt_exe%
	::%dk_call% dk_assertPath "%tcc-rt_exe%"
	
	echo(
	if NOT EXIST "%DKSCRIPT_PATH%"			(set "DKSCRIPT_PATH=%~3")
	echo DKSCRIPT_PATH = %DKSCRIPT_PATH%
	::%dk_call% dk_assertPath "%DKSCRIPT_PATH%"
	
	echo(
	if NOT defined DKSCRIPT_ARGS			(for /F "usebackq tokens=4*" %%a in ('%*') do set DKSCRIPT_ARGS=%%b)
	echo DKSCRIPT_ARGS = %DKSCRIPT_ARGS%
	
	::###### run script ######
	:: "%tcc-rt_exe%"	path to tcc.exe
	:: /V:ON		enable delayed expansion
	:: /K			keep the window open at the TCC prompt.
	echo(
	echo "%tcc-rt_exe%" /V:ON /K call "%DKSCRIPT_PATH%"
	"%tcc-rt_exe%" /V:ON /K call "%DKSCRIPT_PATH%"
	::"%tcc-rt_exe%" /V:ON /K call "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%

	::###### exit_code ######
	if %errorlevel% neq 0 (
		echo exit_code:%errorlevel%
	)
	pause
%endfunction%
















:DKINSTALL
	if "%~1" neq "" (goto:eof)
	
	@echo off&::###### DK.cmd #########################################################################################################################
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/") 
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
	::#################################################################################################################################################
	
	::###### Install DKtcc ######
	%dk_call% dk_echo "Installing DKtcc . . ."
	%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_assertPath "%DKBATCH_FUNCTIONS_DIR%"
	%dk_call% dk_validate DKTOOLS_DIR 			"%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_assertPath "%DKTOOLS_DIR%"
	%dk_call% dk_validate DKIMPORTS_DIR 		"%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_assertPath "%DKIMPORTS_DIR%"
	%dk_call% dk_validate tcc-rt_exe 			"%dk_call% dk_depend tcc-rt"
	%dk_call% dk_assertPath "%tcc-rt_exe%"
	
	::%dk_call% dk_registryDeleteKey 	"HKCR/DKtcc"
	ftype DKtcc="%ComSpec%" /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%tcc-rt_exe%" "%%1" %%*
	%dk_call% dk_registrySetKey 	"HKCR/DKtcc/DefaultIcon" "" "REG_SZ" "%tcc-rt_exe%"
	::%dk_call% dk_registryDeleteKey 	"HKCR/.cmd"
	::%dk_call% dk_registryDeleteKey 	"HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.cmd"
	assoc .cmd=DKtcc
	::assoc .tcc=DKtcc
	
	%dk_call% dk_success "DKtcc install complete"
%endfunction%




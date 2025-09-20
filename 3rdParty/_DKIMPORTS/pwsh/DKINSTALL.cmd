@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	set "pwsh_Import=!pwsh_%Host_Tuple%_Import!"
	%dk_call% dk_assertVar pwsh_Import
	
	::###### pwsh_Import -> TO -> PWSH ######
	::%dk_call% dk_basename %pwsh_Import% pwsh_Import_File
	::%dk_call% dk_removeExtension %pwsh_Import_File% pwsh_Import_Name
	::%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	::%dk_call% dk_set PWSH "%DKTOOLS_DIR%/%pwsh_Import_Name%"
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables %pwsh_Import% INSTALL_ROOT %DKTOOLS_DIR%
	%dk_call% dk_assertVar PWSH
	
	%dk_call% dk_set pwsh_exe "%PWSH%/pwsh.exe"
	if EXIST "%pwsh_exe%" (%return%)
	
	%dk_call% dk_echo  
	%dk_call% dk_info "Installing pwsh . . ."
	%dk_call% dk_download %pwsh_Import%
	%dk_call% dk_smartExtract "%dk_download%" "%PWSH%"
	%dk_call% dk_assertFile pwsh_exe
	
	::### Add File Associations ###
	::%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	::%dk_call% dk_depend pwsh/fileAssoc
	
:: install via CMake
::	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
::	%dk_call% dk_cmakeEval "dk_load(%DKIMPORTS_DIR%/pwsh/DKINSTALL.cmake)" "pwsh_exe"

	::%dk_call% dk_checkError
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% DKINSTALL
%endfunction%


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
	set "POWERSHELL_IMPORT=!Powershell_%Host_Tuple%_Import!"
	%dk_call% dk_assertVar POWERSHELL_IMPORT
	
	::###### POWERSHELL_IMPORT -> TO -> POWERSHELL_DIR ######
	::%dk_call% dk_basename %POWERSHELL_IMPORT% POWERSHELL_IMPORT_FILE
	::%dk_call% dk_removeExtension %POWERSHELL_IMPORT_FILE% POWERSHELL_FOLDER
	::%dk_call% dk_convertToCIdentifier %POWERSHELL_FOLDER% POWERSHELL_FOLDER
	::%dk_call% dk_toLower %POWERSHELL_FOLDER% POWERSHELL_FOLDER
	::%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	::%dk_call% dk_set POWERSHELL_DIR "%DKTOOLS_DIR%/%POWERSHELL_FOLDER%"
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables %POWERSHELL_IMPORT% ROOT %DKTOOLS_DIR%
	%dk_call% dk_assertVar POWERSHELL
	
	%dk_call% dk_set POWERSHELL_EXE "%POWERSHELL%/pwsh.exe"
	if EXIST "%POWERSHELL_EXE%" (%return%)
	
	%dk_call% dk_echo  
	%dk_call% dk_info "Installing powershell . . ."
	%dk_call% dk_download %POWERSHELL_IMPORT%
	%dk_call% dk_smartExtract "%dk_download%" "%POWERSHELL%"
	%dk_call% dk_assertFile POWERSHELL_EXE
	
	::### Add File Associations ###
	::%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	::%dk_call% dk_depend powershell/fileAssoc
	
:: install via CMake
::	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
::	%dk_call% dk_cmakeEval "dk_load(%DKIMPORTS_DIR%/powershell/DKINSTALL.cmake)" "POWERSHELL_EXE"

	::%dk_call% dk_checkError
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% DKINSTALL
%endfunction%


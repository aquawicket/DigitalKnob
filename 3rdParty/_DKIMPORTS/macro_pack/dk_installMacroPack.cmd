@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installMacroPack()
::#
:dk_installMacroPack
	call dk_debugFunc 0
:: setlocal
 
	%dk_call% dk_validate HOST_TRIPLE    "%dk_call% dk_HOST_TRIPLE"
    %dk_call% dk_set MACROPACK_DL "https://github.com/sevagas/macro_pack/releases/download/v2.2.0/macro_pack.exe"
	if not defined MACROPACK_DL         %dk_call% dk_error "MACROPACK_DL is invalid"
	
	%dk_call% dk_basename %MACROPACK_DL% MACROPACK_DL_FILE
	%dk_call% dk_removeExtension %MACROPACK_DL_FILE% MACROPACK_FOLDER
	::%dk_call% dk_convertToCIdentifier %MACROPACK_FOLDER% MACROPACK_FOLDER
	%dk_call% dk_toLower %MACROPACK_FOLDER% MACROPACK_FOLDER
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_set MACROPACK_DIR "%DKTOOLS_DIR%\%MACROPACK_FOLDER%"
	
	%dk_call% dk_set MACROPACK_EXE "%MACROPACK_DIR%\%MACROPACK_DL_FILE%"
	
	if exist "%MACROPACK_EXE%" goto:macropack_installed
	%dk_call% dk_echo   
    %dk_call% dk_info "Installing macropack . . ."
    %dk_call% dk_download %MACROPACK_DL% %MACROPACK_EXE%

	if NOT exist "%MACROPACK_EXE%" %dk_call% dk_error "cannot find MACROPACK_EXE:%MACROPACK_EXE%"
	:macropack_installed
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
 setlocal
 
	call dk_installMacroPack
%endfunction%

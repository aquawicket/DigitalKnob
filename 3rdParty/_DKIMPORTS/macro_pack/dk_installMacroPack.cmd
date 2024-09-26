@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installMacroPack()
::#
:dk_installMacroPack
	call dk_debugFunc 0
	
	call dk_validate DK_HOST_OS "call dk_getHostTriple"
    call dk_set MACROPACK_DL "https://github.com/sevagas/macro_pack/releases/download/v2.2.0/macro_pack.exe"
	if not defined MACROPACK_DL call dk_error "MACROPACK_DL is invalid"
	
	call dk_basename %MACROPACK_DL% MACROPACK_DL_FILE
	call dk_removeExtension %MACROPACK_DL_FILE% MACROPACK_FOLDER
	::call dk_convertToCIdentifier %MACROPACK_FOLDER% MACROPACK_FOLDER
	call dk_toLower %MACROPACK_FOLDER% MACROPACK_FOLDER
	call dk_validate DKTOOLS_DIR "call dk_DKTOOLS_DIR"
	call dk_set MACROPACK_DIR "%DKTOOLS_DIR%\%MACROPACK_FOLDER%"
	
	
	call dk_set MACROPACK_EXE "%MACROPACK_DIR%\%MACROPACK_DL_FILE%"
	
	if exist "%MACROPACK_EXE%" goto:macropack_installed
	call dk_echo   
    call dk_info "Installing macropack . . ."
    call dk_download %MACROPACK_DL% %MACROPACK_EXE%

	if NOT exist "%MACROPACK_EXE%" call dk_error "cannot find MACROPACK_EXE:%MACROPACK_EXE%"
	:macropack_installed
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installMacroPack
%endfunction%

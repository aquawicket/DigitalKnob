@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_installTCC_RT()
::#
:dk_installTCC_RT
	call dk_debugFunc 0
	
	https://jpsoft.com/downloads/v32/tcc-rt.exe
	call dk_validate DK_HOST_OS "call dk_getHostTriple"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_x86"     call dk_set TCC_RT_DL "https://jpsoft.com/downloads/v32/tcc-rt.exe"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_x86_64"  call dk_set TCC_RT_DL "https://jpsoft.com/downloads/v32/tcc-rt.exe"
	if not defined TCC_RT_DL call dk_error "TCC_RT_DL is invalid"
	
	call dk_basename %TCC_RT_DL% TCC_RT_DL_FILE
	call dk_removeExtension %TCC_RT_DL_FILE% TCC_RT_FOLDER
	call dk_convertToCIdentifier %TCC_RT_FOLDER% TCC_RT_FOLDER
	call dk_toLower %TCC_RT_FOLDER% TCC_RT_FOLDER
	
	call dk_validate DKTOOLS_DIR "call dk_setDKTOOLS_DIR"
	call dk_set TCC_RT_DIR "%DKTOOLS_DIR%\%TCC_RT_FOLDER%"
	call dk_set TCC_RT_EXE "%TCC_RT_DIR%\tcc.exe"
	
	if exist "%TCC_RT_EXE%" goto:tcc_rt_installed
	call dk_echo   
    call dk_info "Installing tcc . . ."
    call dk_download %TCC_RT_DL%
    
	call dk_getNativePath %TCC_RT_DIR% TCC_RT_INSTALL_PATH
	call %command_string% "%DKDOWNLOAD_DIR%\%TCC_RT_DL_FILE%" /extract %TCC_RT_DIR%
	call MSIExec /i "%DKDOWNLOAD_DIR%\tcc-rt.msi" INSTALLDIR="%TCC_RT_DIR%"
	
	::if NOT exist "%TCC_RT_EXE%" call dk_error "cannot find TCC_RT_EXE:%TCC_RT_EXE%"
	:tcc_rt_installed
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installTCC_RT
goto:eof
